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
path "sys/policies/acl/*" { capabilities = ["read", "list"] }
EOT
}

resource "vault_policy" "auth_model_policy" {
    name = "auth_model"
  policy = <<EOT
path "secret/data/auth-api-creds" {
  capabilities = ["create", "read", "update", "patch"]
}
EOT
}

resource "vault_policy" "auth_api_policy" {
    name = "auth_api"
  policy = <<EOT
path "secret/data/auth-api-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "openfga_policy" {
    name = "openfga"
  policy = <<EOT
path "secret/data/openfga-db-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "chirpstack_policy" {
    name = "chirpstack"
  policy = <<EOT
path "secret/data/chirpstack-db-creds" {
  capabilities = ["read"]
}
path "secret/data/chirpstack-webhook-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "timescale_policy" {
    name = "timescale"
  policy = <<EOT
path "secret/data/timescale-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "rriv_api_policy" {
    name = "rriv_api"
  policy = <<EOT
path "secret/data/rriv-api-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "data_api_policy" {
    name = "data_api"
  policy = <<EOT
path "secret/data/data-api-creds" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "keycloak_policy" {
  name = "keycloak"
  policy = <<EOT
path "secret/data/keycloak-db-creds" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_policy" "headscale_policy" {
  name = "headscale"
  policy = <<EOT
path "secret/data/vpn-secrets" {
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
path "secret/data/timescale-creds" {
  capabilities = ["read"]
}
path "secret/metadata/timescale-creds" {
  capabilities = ["read"]
}
path "secret/data/digitalocean-dns-api-key" {
  capabilities = ["read"]
}
path "secret/metadata/digitalocean-dns-api-key" {
  capabilities = ["read"]
}
EOT
}
