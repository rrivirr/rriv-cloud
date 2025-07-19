output "admin_username" {
  value = random_pet.keycloak_bootstrap_admin_username.id
  description = "Username for the Keycloak bootstrap admin user"
}

output "admin_password" {
  value = random_password.keycloak_bootstrap_admin_password.result
  description = "Password for the Keycloak bootstrap admin user"
}