output "rriv_app_connection_string" {
  value     = digitalocean_database_connection_pool.rriv_app_pool.uri
  sensitive = true
  description = "Connection string for the chirpstack database"
}

output "keycloak_connection_string" {
  value     = digitalocean_database_connection_pool.keycloak_pool.uri
  sensitive = true
  description = "Connection string for the keycloak database"
}