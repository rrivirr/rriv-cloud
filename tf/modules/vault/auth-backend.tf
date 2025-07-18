resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
  path = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "config" {
  backend = vault_auth_backend.kubernetes.path

  kubernetes_host = "https://kubernetes.default.svc"
  kubernetes_ca_cert = var.kubernetes_ca_cert
  token_reviewer_jwt = var.token_reviewer_jwt
}

# Role for Terraform to modify Vault resources
resource "vault_kubernetes_auth_backend_role" "terraform" {
  backend       = vault_auth_backend.kubernetes.path
  role_name     = "terraform"
  bound_service_account_names      = [var.vault_auth_service_account_name]
  bound_service_account_namespaces = ["vault"]
  token_ttl     = 3600
  token_policies = [
    vault_policy.terraform_admin_policy.name
  ]
}

resource "vault_kubernetes_auth_backend_role" "webapp" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "webapp"
  bound_service_account_names      = ["internal-app"]
  bound_service_account_namespaces = ["default"]

  token_policies = [vault_policy.webapp_policy.name]
  token_ttl      = 3600
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
  path = "userpass"
}