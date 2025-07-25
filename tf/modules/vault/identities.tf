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

  lifecycle {
    ignore_changes = [data_json] # optional, avoids overwriting password managed by random_password
  }
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

resource "vault_identity_entity" "zaven" {
  name      = "zaven"
  policies  = ["users", "webapp", "oidc-provider"]

  lifecycle {
    ignore_changes = [policies] # optional, avoids overwriting policies managed by groups
  }
}


resource "vault_generic_endpoint" "zaven_user" {
  depends_on = [vault_auth_backend.userpass]

  path = "auth/userpass/users/zaven"

  data_json = jsonencode({
    password = random_password.zaven_password.result
    policies = ["users", "webapp", "oidc-provider"]
  })

  lifecycle {
    ignore_changes = [data_json] # optional, avoids overwriting password managed by random_password
  }
}

resource "vault_identity_entity_alias" "zaven_userpass" {
  name           = "zaven"
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.zaven.id
}

resource "random_password" "zaven_password" {
  length  = 20
  special = true
}