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

}

resource "keycloak_openid_client" "auth_api" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "auth-api"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "CONFIDENTIAL"
  service_accounts_enabled = true
  direct_access_grants_enabled = true
}

resource "keycloak_openid_client" "rriv_api" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "rriv-api"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "CONFIDENTIAL"
  service_accounts_enabled = true
  direct_access_grants_enabled = true
}

resource "keycloak_openid_client" "data_api" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "data-api"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "CONFIDENTIAL"
  direct_access_grants_enabled = true
}

resource "keycloak_openid_client" "web_client" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "rriv-web"
  name                = "$${client_account}"
  enabled             = false
  access_type         = "PUBLIC"
  standard_flow_enabled = true
  direct_access_grants_enabled = false

  valid_redirect_uris = [
    "http://localhost:5173/*",
  ]

   valid_post_logout_redirect_uris = [
    "http://localhost:5173/*",
  ]

  web_origins = [
    "http://localhost:5173"
  ]

  pkce_code_challenge_method = "S256"
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
