locals {
  rriv_api_database_url = "postgresql://rriv-api:${digitalocean_database_user.rriv_api.password}@${digitalocean_database_cluster.rriv.private_host}:${digitalocean_database_cluster.rriv.port}/rriv-app?sslmode=require"
  data_api_database_url = "postgresql://data-api:${digitalocean_database_user.data_api.password}@${digitalocean_database_cluster.rriv.private_host}:${digitalocean_database_cluster.rriv.port}/rriv-app?sslmode=require"
}
