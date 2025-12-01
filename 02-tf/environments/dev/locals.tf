locals {
  env = "dev"
  do_region = "sfo2"
  vault_cluster_node_count = 3
  vault_cluster_node_size = "s-2vcpu-4gb"
  rriv_cluster_node_count = 3
  rriv_cluster_node_size = "s-2vcpu-4gb"
  vpc_octet = 10  # 10.10.0.0/16
  vault_kv_secret_tags = {
    "env" = local.env
    "iac" = "terraform"
    "repo" = "github.com/rrivirr/rriv-cloud"
    "do_region" = local.do_region
  }
}
