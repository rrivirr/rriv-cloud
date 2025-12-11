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

# TODO: separate or use paths with *
resource "vault_policy" "webapp_policy" {
  name = "webapp"
  policy = <<EOT
path "secret/data/${var.env}-chirpstack-db-creds" {
  capabilities = ["read"]
}
path "secret/data/${var.env}-timescale-creds" {
  capabilities = ["read"]
}
path "secret/data/${var.env}-rriv-api-creds" {
  capabilities = ["read"]
}
path "secret/data/${var.env}-data-api-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "keycloak_policy" {
  name = "keycloak"
  policy = <<EOT
path "secret/data/${var.env}-keycloak-db-creds" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_policy" "headscale_policy" {
  name = "headscale"
  policy = <<EOT
path "secret/data/${var.env}-vpn-secrets" {
  capabilities = ["read", "list"]
}
EOT
}

# resource "vault_policy" "oidc_provider_policy" {
#   name = "oidc-provider"
#   policy = <<EOT
# path "identity/oidc/provider/rriv-internal/authorize" {
#   capabilities = ["read"]
# }
# EOT
# }

resource "vault_policy" "services_external_secrets_policy" {
  name = "services-external-secrets"
  policy = <<EOT
# Allow External Secrets Operator to read secrets from the KV store
path "secret/data/${var.env}-timescale-creds" {
  capabilities = ["read"]
}
path "secret/metadata/${var.env}-timescale-creds" {
  capabilities = ["read"]
}
path "secret/data/${var.env}-digitalocean-dns-api-key" {
  capabilities = ["read"]
}
path "secret/metadata/${var.env}-digitalocean-dns-api-key" {
  capabilities = ["read"]
}
EOT
}
