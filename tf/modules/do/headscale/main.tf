resource "digitalocean_ssh_key" "ssh_key_vpn_admin" {
  name       = "rriv-vpn-admin-key"
  public_key = var.ssh_key_public
}

resource "digitalocean_volume" "headscale_data" {
  region                  = var.region
  name                    = "headscale-data"
  size                    = 10 # GB
  initial_filesystem_type = "ext4"
  description             = "Persistent storage for Headscale VPN server"
}

resource "digitalocean_reserved_ip" "headscale" {
  region = var.region
}

resource "digitalocean_droplet" "headscale" {
  image  = data.digitalocean_droplet_snapshot.headscale_base_image.id
  name   = "headscale-vpn"
  region = var.region
  size   = var.droplet_size

  ssh_keys = [digitalocean_ssh_key.ssh_key_vpn_admin.id]

  user_data = templatefile("${path.module}/cloud-init.yaml", {
    domain             = "vpn.rriv.org"
    base_domain        = "tailnet.rriv.org"
    oidc_issuer        = var.oidc_issuer
    oidc_client_id     = var.oidc_client_id
    oidc_client_secret = var.oidc_client_secret
    admin_email        = var.admin_email
    admin_ip           = var.admin_ip
    gated_services     = var.gated_services
  })

  tags = ["headscale", "vpn", "management"]
}

resource "digitalocean_volume_attachment" "headscale_data" {
  droplet_id = digitalocean_droplet.headscale.id
  volume_id  = digitalocean_volume.headscale_data.id
}

resource "digitalocean_record" "headscale" {
  domain = "rriv.org"
  type   = "A"
  name   = "vpn"
  value  = digitalocean_reserved_ip.headscale.ip_address

  lifecycle {
    replace_triggered_by = [
      digitalocean_reserved_ip.headscale.ip_address
    ]
  }
}

resource "digitalocean_record" "tailnet" {
  domain = "rriv.org"
  type   = "A"
  name   = "tailnet"
  value  = digitalocean_reserved_ip.headscale.ip_address

  lifecycle {
    replace_triggered_by = [
      digitalocean_reserved_ip.headscale.ip_address
    ]
  }
}

resource "digitalocean_record" "tailnet_wildcard" {
  domain = "rriv.org"
  type   = "A"
  name   = "*.tailnet"
  value  = digitalocean_reserved_ip.headscale.ip_address

  lifecycle {
    replace_triggered_by = [
      digitalocean_reserved_ip.headscale.ip_address
    ]
  }
}

resource "digitalocean_firewall" "headscale" {
  name = "headscale-firewall"
  
  droplet_ids = [digitalocean_droplet.headscale.id]
  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["${var.admin_ip}/32"]
  }
  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_reserved_ip_assignment" "headscale" {
  ip_address = digitalocean_reserved_ip.headscale.ip_address
  droplet_id = digitalocean_droplet.headscale.id
  
  depends_on = [
    digitalocean_droplet.headscale,
    digitalocean_volume_attachment.headscale_data
  ]
}
