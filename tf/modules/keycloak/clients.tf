resource "keycloak_openid_client" "tailscale" {
  realm_id            = keycloak_realm.rriv_beta.id
  client_id           = "tailscale"
  name                = "Tailscale VPN"
  enabled             = true
  client_secret       = "auto-generate-or-set-manually"
  access_type         = "CONFIDENTIAL"
  standard_flow_enabled = true
  direct_access_grants_enabled = false

  valid_redirect_uris = [
    "https://login.tailscale.com/a/oauth_callback"
  ]

  base_url                     = "https://login.tailscale.com"
  admin_url                    = "https://login.tailscale.com"
  # client_secret                = var.tailscale_client_secret
}

resource "keycloak_openid_user_attribute_protocol_mapper" "preferred_username" {
  name             = "preferred_username"
  realm_id         = keycloak_realm.rriv_beta.id
  client_id        = keycloak_openid_client.tailscale.id
  user_attribute   = "username"
  claim_name       = "preferred_username"
  claim_value_type = "String"

  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}
