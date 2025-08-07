data "digitalocean_database_ca" "ca" {
  cluster_id = digitalocean_database_cluster.rriv.id
}

resource "digitalocean_database_cluster" "rriv" {
  name                 = "rriv-${var.env}"
  engine               = "pg"
  version              = "16"
  size                 = "db-s-1vcpu-1gb"
  region               = "sfo2"
  node_count           = 1
  private_network_uuid = var.vpc_id
}

# chirpstack
resource "digitalocean_database_user" "chirpstack" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "chirpstack"
}

resource "digitalocean_database_db" "chirpstack" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "chirpstack"
  depends_on = [digitalocean_database_user.chirpstack]
}

# keycloak
resource "digitalocean_database_user" "keycloak" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "keycloak"
}

resource "digitalocean_database_db" "keycloak" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "keycloak"
  depends_on = [digitalocean_database_user.keycloak]
}

# rriv app
resource "digitalocean_database_user" "rriv_api" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "rriv-api"
}

resource "digitalocean_database_user" "data_api" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "data-api"
}

resource "digitalocean_database_db" "rriv_app" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "rriv-app"
  depends_on = [digitalocean_database_user.rriv_api]
}

# connection pool for chirpstack
resource "digitalocean_database_connection_pool" "rriv_app_pool" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = digitalocean_database_db.chirpstack.name
  mode       = "transaction"
  size       = 5
  db_name    = digitalocean_database_db.chirpstack.name
  user       = "chirpstack"
}

