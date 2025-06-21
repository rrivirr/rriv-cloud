resource "digitalocean_droplet" "tailscale_node" {
  image  = "ubuntu-22-04-x64"
  name   = "tailscale-exit-node"
  region = var.do_region
  size   = var.droplet_size
  ssh_keys = [var.ssh_fingerprint]

  user_data = <<-EOF
              #!/bin/bash
              curl -fsSL https://tailscale.com/install.sh | sh
              tailscale up --authkey=${var.tailscale_authkey} --advertise-exit-node --accept-routes --hostname=exit-node
              EOF
}

resource "digitalocean_firewall" "allow_ssh_tailscale" {
  name = "allow-ssh-tailscale"

  droplet_ids = [digitalocean_droplet.tailscale_node.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Used by Tailscale for peer-to-peer traffic
  inbound_rule {
    protocol         = "udp"
    port_range       = "41641"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol   = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol   = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol   = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}