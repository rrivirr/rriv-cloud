locals {
  env = "dev"
  do_region = "sfo2"
  vault_cluster_node_count = 3
  rriv_cluster_node_count = 3

  vault_tls_cert_json = {
    cert = file(var.vault_tls_cert_file)
    key  = file(var.vault_tls_key_file)
    ca   = file(var.vault_tls_ca_file)
  }
}