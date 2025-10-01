output "keycloak_smtp_creds" {
  value = jsondecode(resource.vault_kv_secret_v2.keycloak_smtp_creds.data_json)
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

output "daniel_password" {
  value = random_password.daniel_password.result
  sensitive = true
}
