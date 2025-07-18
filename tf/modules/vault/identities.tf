resource "vault_identity_entity" "kat" {
  name      = "kat"
  policies  = ["users", "webapp", "keycloak", "oidc-provider"]

  lifecycle {
    ignore_changes = [policies] # optional, avoids overwriting policies managed by groups
  }
}


resource "vault_generic_endpoint" "kat_user" {
  depends_on = [vault_auth_backend.userpass]

  path = "auth/userpass/users/kat"

  data_json = jsonencode({
    password = random_password.kat_password.result
    policies = ["users", "webapp", "keycloak", "oidc-provider"]
  })
}

resource "vault_identity_entity_alias" "kat_userpass" {
  name           = "kat"
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.kat.id
}

resource "random_password" "kat_password" {
  length  = 20
  special = true
}