output "rriv_org_lb_ip" {
  value = data.digitalocean_loadbalancer.ingress_nginx_lb.ip
}

# Not sure we need this one
output "chirp_lb_ip" {
  value = data.digitalocean_loadbalancer.chirp_lb.ip
}
output "chirp_console_lb_ip" {
  value = data.digitalocean_loadbalancer.chirp_console_lb.ip
}
output "vault_lb_ip" {
  value = data.digitalocean_loadbalancer.vault_lb.ip
}