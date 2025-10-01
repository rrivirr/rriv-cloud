# output "vault_auth_token_data" {
#   value = data.kubernetes_secret.vault_auth_token_data.data.token
# }

# output "vault_auth_ca_cert" {
#   value = data.kubernetes_secret.vault_auth_token_data.data["ca.crt"]
# }


# TODO: delete
output "do_dns_api_token" {
  value = kubernetes_secret.do_dns_api_token.data
}