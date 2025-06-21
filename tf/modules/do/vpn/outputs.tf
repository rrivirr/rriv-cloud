output "droplet_ip" {
  value = digitalocean_droplet.tailscale_node.ipv4_address
}