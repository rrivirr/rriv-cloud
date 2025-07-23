resource "aws_secretsmanager_secret" "vault_tls_cert" {
  name        = "rriv-${var.env}-vault-tls-cert"
  description = "TLS cert, CA, and key for Vault in ${var.env} environment"
}

resource "aws_secretsmanager_secret_version" "vault_tls_cert" {
  secret_id     = aws_secretsmanager_secret.vault_tls_cert.id
  secret_string = jsonencode({
    cert = file("certs/vault-tls.crt")
    key  = file("certs/vault-tls.key")
    ca   = file("certs/vault-tls.ca")
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}
