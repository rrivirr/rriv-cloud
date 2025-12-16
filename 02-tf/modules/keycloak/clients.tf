resource "keycloak_openid_client" "rrivctl" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "rrivctl"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "PUBLIC"
  standard_flow_enabled = true
  direct_access_grants_enabled = true
  full_scope_allowed = false
  access_token_lifespan = 8640000
  client_session_idle_timeout = 864000 
  client_session_max_lifespan = 8640000

  valid_redirect_uris = [
    "${local.rrivctl_redirect_relative_uri}/*",
    "/oidc/callback"
  ]

  base_url = "https://${local.rrivctl_subdomain}.${var.domain}"
}

resource "keycloak_openid_client" "rriv-api" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "rriv-api"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "CONFIDENTIAL"
  full_scope_allowed = false
  service_accounts_enabled = true

  valid_redirect_uris = [
    "${local.rrivctl_redirect_relative_uri}/*",
    "/oidc/callback"
  ]

  base_url = "https://${local.rrivctl_subdomain}.${var.domain}"
}

resource "keycloak_openid_client_service_account_realm_role" "client_service_account_role" {
  realm_id                = keycloak_realm.rriv_beta.id
  service_account_user_id = keycloak_openid_client.rriv-api.service_account_user_id
  role                    = "manage-users"
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
