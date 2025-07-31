output "vault_iam_user_name" {
  description = "The name of the Vault IAM user"
  value       = aws_iam_user.vault_user.name
}
