# Auth backend for RRIV cluster
resource "vault_auth_backend" "kubernetes_rriv" {
  type = "kubernetes"
  path = "kubernetes-rriv"
  description = "Kubernetes auth backend for RRIV cluster (for application workloads)"
}

resource "vault_kubernetes_auth_backend_config" "rriv_config" {
  backend = vault_auth_backend.kubernetes_rriv.path

  kubernetes_host = var.rriv_kubernetes_host
  kubernetes_ca_cert = var.rriv_kubernetes_ca_cert
  token_reviewer_jwt = var.rriv_token_reviewer_jwt
}

resource "vault_kubernetes_auth_backend_role" "terraform_rriv" {
  backend       = vault_auth_backend.kubernetes_rriv.path
  role_name     = "terraform"
  bound_service_account_names      = [var.vault_auth_service_account_name]
  bound_service_account_namespaces = ["vault"]
  token_ttl     = 3600
  token_policies = [
    vault_policy.terraform_admin_policy.name
  ]
}

resource "vault_kubernetes_auth_backend_role" "webapp" {
  backend                          = vault_auth_backend.kubernetes_rriv.path
  role_name                        = "webapp"
  bound_service_account_names      = ["internal-app"]
  bound_service_account_namespaces = ["default"]

  token_policies = [vault_policy.webapp_policy.name]
  token_ttl      = 3600
}

resource "vault_kubernetes_auth_backend_role" "keycloak" {
  backend                          = vault_auth_backend.kubernetes_rriv.path
  role_name                        = "keycloak"
  bound_service_account_names      = [var.keycloak_auth_service_account_name]
  bound_service_account_namespaces = ["default"]

  token_policies = [vault_policy.keycloak_policy.name]
  token_ttl      = 3600
}

resource "vault_kubernetes_auth_backend_role" "headscale" {
  backend                          = vault_auth_backend.kubernetes_rriv.path
  role_name                        = "headscale"
  bound_service_account_names      = [var.headscale_auth_service_account_name]
  bound_service_account_namespaces = ["headscale"]

  token_policies = [vault_policy.headscale_policy.name]
  token_ttl      = 3600
}

# Role for microservice Secrets Operator
resource "vault_kubernetes_auth_backend_role" "services_external_secrets" {
  backend                          = vault_auth_backend.kubernetes_rriv.path
  role_name                        = "services-external-secrets"
  bound_service_account_names      = ["external-secrets"]
  bound_service_account_namespaces = ["external-secrets"]

  token_policies = [vault_policy.services_external_secrets_policy.name]
  token_ttl      = 3600
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
  path = "userpass"
}