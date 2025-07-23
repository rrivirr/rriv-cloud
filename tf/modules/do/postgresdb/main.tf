data "digitalocean_database_ca" "ca" {
  cluster_id = digitalocean_database_cluster.rriv.id
}

resource "digitalocean_database_db" "chirpstack" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "chirpstack"
}

resource "digitalocean_database_db" "keycloak" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "keycloak"
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

resource "digitalocean_database_connection_pool" "rriv_app_pool" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = digitalocean_database_db.chirpstack.name
  mode       = "transaction"
  size       = 5
  db_name    = digitalocean_database_db.chirpstack.name
  user       = "chirpstack"
}

resource "digitalocean_database_connection_pool" "keycloak_pool" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = digitalocean_database_db.keycloak.name
  mode       = "transaction"
  size       = 10
  db_name    = digitalocean_database_db.keycloak.name
  user       = "keycloak"
}

resource "digitalocean_database_user" "chirpstack" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "chirpstack"
}

resource "digitalocean_database_user" "keycloak" {
  cluster_id = digitalocean_database_cluster.rriv.id
  name       = "keycloak"
}