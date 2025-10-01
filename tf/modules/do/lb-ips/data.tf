data "digitalocean_loadbalancer" "ingress_nginx_lb" {
  name = "ingress-nginx-controller-${var.env}"
}

data "digitalocean_loadbalancer" "chirp_lb" {
  name = "chirpstack-${var.env}"
}

data "digitalocean_loadbalancer" "chirp_console_lb" {
  name = "chirpstack-gateway-bridge-${var.env}"
}

data "digitalocean_loadbalancer" "vault_lb" {
  name = "vault-${var.env}"
}
