resource "digitalocean_domain" "do_sfo2_domain" {
  count = var.env == "prod" ? 1 : 0 # We don't need to create the domain if it's a subdomain
  
  name = local.root_domain
}

resource "digitalocean_record" "do_sfo2_auth_a_record" {
  domain = local.root_domain
  name   = "auth.${var.env}"
  type   = "A"
  value  = var.rriv_org_lb_ip
  ttl    = 1800
}

resource "digitalocean_record" "do_sfo2_api_a_record" {
  domain = local.root_domain
  name   = "api.${var.env}"
  type   = "A"
  value  = var.rriv_org_lb_ip
  ttl    = 1800
}

resource "digitalocean_record" "do_sfo2_chirp_a_record" {
  domain = local.root_domain
  name   = "chirp.${var.env}"
  type   = "A"
  value  = var.rriv_org_lb_ip
  ttl    = 1800
}

resource "digitalocean_record" "do_sfo2_chirp_console_a_record" {
  domain = local.root_domain
  name   = "chirp-console.${var.env}"
  type   = "A"
  value  = var.chirp_console_lb_ip
  ttl    = 1800
}

resource "digitalocean_record" "do_sfo2_vault_a_record" {
  domain = local.root_domain
  name   = "vault.${var.env}"
  type   = "A"
  value  = var.vault_lb_ip
  ttl    = 1800
}