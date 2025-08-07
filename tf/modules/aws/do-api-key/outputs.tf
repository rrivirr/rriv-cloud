output "do_api_key_arn" {
  value = aws_secretsmanager_secret.do_api_key.arn
}

output "secret_github_actions_do_api_key_arn" {
  value = aws_secretsmanager_secret.github_actions_do_api_key.arn
}