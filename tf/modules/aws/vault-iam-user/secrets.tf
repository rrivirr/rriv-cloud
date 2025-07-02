resource "aws_secretsmanager_secret" "vault_tls_cert" {
  name        = "rriv-${var.env}-vault-tls-cert"
  description = "TLS cert, CA, and key for Vault in ${var.env} environment"
}

resource "aws_secretsmanager_secret_version" "vault_tls_cert" {
  secret_id     = aws_secretsmanager_secret.vault_tls_cert.id
  secret_string = jsonencode({
    cert = var.vault_tls_cert_json.cert
    key  = var.vault_tls_cert_json.key
    ca   = var.vault_tls_cert_json.ca
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}
