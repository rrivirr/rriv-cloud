resource "keycloak_openid_client" "headscale" {
  realm_id                     = var.realm_id
  client_id                    = "headscale"
  name                         = "Headscale VPN"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  standard_flow_enabled        = true
  implicit_flow_enabled        = false
  direct_access_grants_enabled = true
  service_accounts_enabled     = false
  valid_redirect_uris          = [
    "https://vpn.${var.domain}/oidc/callback"
  ]
  web_origins                  = [
    "https://vpn.${var.domain}"
  ]
  root_url                     = "https://vpn.${var.domain}"
  base_url                     = "/"
}

resource "keycloak_openid_user_attribute_protocol_mapper" "preferred_username" {
  name             = "preferred_username"
  realm_id         = var.realm_id
  client_id        = keycloak_openid_client.headscale.id
  user_attribute   = "username"
  claim_name       = "preferred_username"
  claim_value_type = "String"

  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}
