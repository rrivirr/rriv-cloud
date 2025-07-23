# Note: LBs must be manually renamed in the DO UI to match this name
data "digitalocean_loadbalancer" "vault" {
  name = "vault-${var.env}-lb"
}

# Note: LBs must be manually renamed in the DO UI to match this name
data "digitalocean_loadbalancer" "rriv_app" {
  name = "rriv-app-${var.env}-lb"
}

# Create a new domain
resource "digitalocean_domain" "vault" {
  name       = "${local.vault_subdomain}.${var.domain}"
  ip_address = data.digitalocean_loadbalancer.vault.ip
}

resource "digitalocean_domain" "chirpstack" {
  name       = "${local.chirpstack_subdomain}.${var.domain}"
  ip_address = data.digitalocean_loadbalancer.rriv_app.ip
}

resource "digitalocean_domain" "chirpstack_console" {
  name       = "${local.chirpstack_console_subdomain}.${var.domain}"
  ip_address = data.digitalocean_loadbalancer.rriv_app.ip
}

resource "digitalocean_domain" "keycloak" {
  name       = "${local.keycloak_subdomain}.${var.domain}"
  ip_address = data.digitalocean_loadbalancer.rriv_app.ip
}
