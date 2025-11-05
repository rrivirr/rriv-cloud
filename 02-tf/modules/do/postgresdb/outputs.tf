output "rriv_app_pool_connection_string" {
  value     = digitalocean_database_connection_pool.rriv_app_pool.private_uri
  sensitive = true
  description = "DB connection string for the chirpstack application pool"
}

output "rriv_app_direct_connection_string" {
  value     = digitalocean_database_cluster.rriv.private_uri
  sensitive = true
  description = "Direct connection string for the chirpstack database"
}

output "keycloak_db_username" {
  value     = "keycloak"
  description = "Username for the keycloak database"
}

output "keycloak_db_password" {
  value     = digitalocean_database_user.keycloak.password
  sensitive = true
  description = "Password for the keycloak database"
}

output "keycloak_db_host" {
  value     = digitalocean_database_cluster.rriv.private_host
  sensitive = true
  description = "Host for the keycloak database"
}

output "keycloak_db_port" {
  value     = digitalocean_database_cluster.rriv.port
  description = "Port for the keycloak database"
}

output "keycloak_db_name" {
  value     = digitalocean_database_db.keycloak.name
  description = "Name of the keycloak database"
}

output "postgresql_ca_cert" {
  value     = data.digitalocean_database_ca.ca.certificate
  sensitive = true
  description = "CA certificate for PostgreSQL SSL connections"
}

output "rriv_api_database_url" {
  value     = local.rriv_api_database_url
  sensitive = true
  description = "Database URL for the RRIV API"
}

output "data_api_database_url" {
  value     = local.data_api_database_url
  sensitive = true
  description = "Database URL for the Data API"
}