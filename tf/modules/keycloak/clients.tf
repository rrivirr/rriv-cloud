resource "keycloak_openid_client" "rrivctl" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "rrivctl"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "PUBLIC"
  standard_flow_enabled = true
  direct_access_grants_enabled = true
  full_scope_allowed = false

  valid_redirect_uris = [
    "${local.rrivctl_redirect_relative_uri}/*",
    "/oidc/callback"
  ]

  base_url = "https://${local.rrivctl_subdomain}.${var.domain}"
}

# # Prod-only module
module "headscale_openid_client" {
  count = var.env == "dev" ? 1 : 0

  providers = {
    keycloak = keycloak
  }

  source = "./modules/headscale-client"
  realm_id = keycloak_realm.rriv_beta.id
  domain = var.domain
}