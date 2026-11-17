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
  direct_access_grants_enabled = false
}

resource "keycloak_openid_client" "rriv_api" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "rriv-api"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "CONFIDENTIAL"
  service_accounts_enabled = true
  direct_access_grants_enabled = false
}
data "keycloak_openid_client" "realm_management" {
  realm_id  = keycloak_realm.rriv_beta.id
  client_id = "realm-management"
}

resource "keycloak_openid_client_service_account_role" "rriv_api_manage_users" {
  realm_id                = keycloak_realm.rriv_beta.id
  service_account_user_id = keycloak_openid_client.rriv_api.service_account_user_id
  client_id               = data.keycloak_openid_client.realm_management.id
  role                    = "manage-users"
}

resource "keycloak_openid_client" "data_api" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "data-api"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "CONFIDENTIAL"
  service_accounts_enabled = true
  direct_access_grants_enabled = false
}

resource "keycloak_openid_client" "web_client" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "rriv-web"
  name                = "$${client_account}"
  enabled             = true
  access_type         = "PUBLIC"
  standard_flow_enabled = true
  direct_access_grants_enabled = false

  valid_redirect_uris = [
    "https://${local.app_url}/*",
  ]

   valid_post_logout_redirect_uris = [
    "https://${local.app_url}/*",
  ]

  web_origins = [
    "https://${local.app_url}"
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
