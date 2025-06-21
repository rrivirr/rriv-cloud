locals {
  env = "dev"
  do_region = "sfo2"

  vault_tls_cert_json = jsonencode({
    cert = file(var.vault_tls_cert_file)
    key  = file(var.vault_tls_key_file)
    ca   = file(var.vault_tls_ca_file)
  })
}