resource "aws_secretsmanager_secret" "do_api_key" {
  name        = "rriv-${var.env}-do-api-key"
  description = "DO API key for Vault in ${var.env} environment"
}

resource "aws_secretsmanager_secret_version" "do_api_key" {
  secret_id     = aws_secretsmanager_secret.do_api_key.id
  secret_string = jsonencode({
    api_token = var.do_api_key
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}