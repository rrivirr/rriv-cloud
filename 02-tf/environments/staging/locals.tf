locals {
  env = "staging"
  do_region = "sfo2"
  vault_cluster_node_count_min = 1
  vault_cluster_node_count_max = 5
  vault_cluster_node_size = "s-1vcpu-2gb"
  rriv_cluster_node_count_min = 1
  rriv_cluster_node_count_max = 5
  rriv_cluster_node_size = "s-2vcpu-4gb"
  vpc_octet = 100
  vault_kv_secret_tags = {
    "env" = local.env
    "iac" = "terraform"
    "repo" = "github.com/rrivirr/rriv-cloud"
    "do_region" = local.do_region
  }
}