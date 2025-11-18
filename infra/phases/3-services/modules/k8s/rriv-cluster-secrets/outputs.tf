output "vault_auth_token_data" {
  value     = try(data.kubernetes_secret.vault_auth_token_data.data.token, null)
  sensitive = true
}

output "vault_auth_ca_cert" {
  value     = try(data.kubernetes_secret.vault_auth_token_data.data["ca.crt"], null)
}
