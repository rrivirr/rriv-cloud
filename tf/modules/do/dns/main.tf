# Note: LBs must be manually renamed in the DO UI to match this name
data "digitalocean_loadbalancer" "vault" {
  name = "vault-${var.env}-lb"
}

# Note: LBs must be manually renamed in the DO UI to match this name
data "digitalocean_loadbalancer" "rriv_app" {
  name = "rriv-app-${var.env}-lb"
}

# Create a new domain
resource "digitalocean_record" "vault" {
  domain = var.domain
  type   = "A"
  name   = local.vault_subdomain
  value  = data.digitalocean_loadbalancer.vault.ip
  ttl   = 3600
}

resource "digitalocean_record" "chirpstack" {
  domain = var.domain
  type   = "A"
  name   = local.chirpstack_subdomain
  value  = data.digitalocean_loadbalancer.rriv_app.ip
  ttl   = 3600
}

resource "digitalocean_record" "chirpstack_console" {
  domain = var.domain
  type   = "A"
  name   = local.chirpstack_console_subdomain
  value  = data.digitalocean_loadbalancer.rriv_app.ip
  ttl   = 3600
}

resource "digitalocean_record" "keycloak" {
  domain = var.domain
  type   = "A"
  name   = local.keycloak_subdomain
  value  = data.digitalocean_loadbalancer.rriv_app.ip
  ttl   = 3600
}
