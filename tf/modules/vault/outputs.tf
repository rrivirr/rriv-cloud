output "keycloak_smtp_creds" {
  value = data.vault_kv_secret_v2.keycloak_smtp_creds.data
  sensitive = true
}

output "kat_password" {
  value = random_password.kat_password.result
  sensitive = true
}

output "zaven_password" {
  value = random_password.zaven_password.result
  sensitive = true
}
