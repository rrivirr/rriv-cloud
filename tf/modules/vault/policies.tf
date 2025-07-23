resource "vault_policy" "terraform_admin_policy" {
  name = "terraform-admin"

  policy = <<EOT
path "sys/policies/acl/*" { capabilities = ["create", "read", "update", "delete", "list"] }
# Auth backend management
path "sys/auth" { capabilities = ["read"] }
path "sys/auth/*" { capabilities = ["create", "read", "update", "delete", "list", "sudo"] }
# Mount info (required for Terraform to manage auth backends)
path "sys/mounts" { capabilities = ["read"] }
path "sys/mounts/*" { capabilities = ["create", "read", "update", "delete", "list"] }
path "auth/kubernetes/*" { capabilities = ["create", "read", "update", "delete", "list"] }
path "auth/kubernetes-rriv/*" { capabilities = ["create", "read", "update", "delete", "list"] }
path "auth/userpass/*" { capabilities = ["create", "read", "update", "delete", "list"] }
path "auth/token/create" { capabilities = ["create", "update", "sudo"] }
path "auth/token/lookup-self" { capabilities = ["read"] }
path "identity/*" { capabilities = ["create", "read", "update", "delete", "list"] }
path "secret/*" { capabilities = ["create", "read", "update", "delete", "list"] }
EOT
}

resource "vault_policy" "users_policy" {
  name = "users"
  policy = <<EOT
path "secret/*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
EOT
}

resource "vault_policy" "webapp_policy" {
  name = "webapp"
  policy = <<EOT
path "secret/data/${var.env}-chirpstack-db-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "keycloak_policy" {
  name = "keycloak"
  policy = <<EOT
path "secret/data/${var.env}-keycloak-creds" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_policy" "oidc_provider_policy" {
  name = "oidc-provider"
  policy = <<EOT
path "identity/oidc/provider/rriv-internal/authorize" {
  capabilities = ["read"]
}
EOT
}
