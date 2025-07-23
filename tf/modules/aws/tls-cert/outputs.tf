output "vault_tls_cert_arn" {
  value = aws_secretsmanager_secret.vault_tls_cert.arn
}