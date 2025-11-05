data "digitalocean_loadbalancer" "ingress_nginx_lb" {
  name = "ingress-nginx-controller-${var.env}"
}

data "digitalocean_loadbalancer" "chirp_lb" {
  name = "chirpstack-${var.env}"
}

data "digitalocean_loadbalancer" "lorawan_lb" {
  name = "gateway-us-${var.env}"
}

data "digitalocean_loadbalancer" "vault_lb" {
  name = "vault-${var.env}"
}
