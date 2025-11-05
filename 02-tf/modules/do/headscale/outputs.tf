output "headscale_url" {
  description = "Headscale server URL"
  value       = "https://vpn.rriv.org"
}

output "headscale_reserved_ip" {
  description = "The reserved (static) IP address of the Headscale server"
  value       = digitalocean_reserved_ip.headscale.ip_address
}

output "headscale_volume_id" {
  description = "The ID of the persistent storage volume"
  value       = digitalocean_volume.headscale_data.id
}

output "headscale_droplet_id" {
  description = "The ID of the Headscale droplet"
  value       = digitalocean_droplet.headscale.id
}