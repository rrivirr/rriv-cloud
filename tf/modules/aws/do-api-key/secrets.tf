resource "aws_secretsmanager_secret" "do_dns_api_key" {
  name        = "rriv-${var.env}-do-dns-api-key"
  description = "DO API key for creating Vault TLS certificate in ${var.env} environment"
}

resource "aws_secretsmanager_secret_version" "do_dns_api_key" {
  secret_id     = aws_secretsmanager_secret.do_dns_api_key.id
  secret_string = jsonencode({
    api_token = var.do_dns_api_key
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret" "github_actions_do_api_key" {
  name        = "rriv-${var.env}-github-actions-do-api-key"
  description = "DO API key for GitHub Actions to access k8s in ${var.env} environment"
}

resource "aws_secretsmanager_secret_version" "github_actions_do_api_key" {
  secret_id     = aws_secretsmanager_secret.github_actions_do_api_key.id
  secret_string = jsonencode({
    api_token = var.do_github_actions_api_key
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}