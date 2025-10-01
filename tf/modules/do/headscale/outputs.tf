output "headscale_ip" {
  description = "Public IP address of the Headscale server"
  value       = digitalocean_droplet.headscale.ipv4_address
}

output "headscale_url" {
  description = "Headscale server URL"
  value       = "https://vpn.rriv.org"
}
