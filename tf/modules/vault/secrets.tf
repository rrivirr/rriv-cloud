resource "vault_mount" "app_secrets" {
  path = "secret"
  type = "kv-v2"
  options     = { version = "2" }

  description = "KV v2 secrets engine for storing application secrets"
}

resource "vault_kv_secret_v2" "keycloak_creds" {
  mount                      = vault_mount.app_secrets.path
  name                       = "${var.env}-keycloak-creds"
  
  data_json = jsonencode({
    keycloak_username = var.keycloak_admin_username,
    keycloak_password = var.keycloak_admin_password,
    db_host     = var.keycloak_db_host,
    db_port     = var.keycloak_db_port,
    db_name     = var.keycloak_db_name,
    db_username = var.keycloak_db_username,
    db_password = var.keycloak_db_password,
  })
}

resource "vault_kv_secret_v2" "digitalocean_dns_api_key" {
  mount = vault_mount.app_secrets.path
  name  = "${var.env}-digitalocean-dns-api-key"

  data_json = jsonencode({
    api-token = var.do_dns_api_key
  })
}

resource "vault_kv_secret_v2" "chirpstack_db_creds" {
  mount                      = vault_mount.app_secrets.path
  name                       = "${var.env}-chirpstack-db-creds"

  data_json = jsonencode({
    pg_chirpstack_pool_connection_string = var.rriv_app_pool_connection_string,
    pg_chirpstack_direct_connection_string = var.rriv_app_direct_connection_string, # Used for setup
    postgresql_ca_cert = var.postgresql_ca_cert,
  })
}

# TODO: add timescale creds as a resource