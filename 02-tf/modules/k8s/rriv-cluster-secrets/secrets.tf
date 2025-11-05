# Get service account token and CA cert from RRIV cluster for Vault authentication
data "kubernetes_secret" "vault_auth_token_data" {
  metadata {
    name      = "vault-auth-token"
    namespace = "vault-system"
  }
}
