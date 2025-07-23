output "vault_kms_key_id" {
  description = "The ID of the KMS key used by Vault"
  value       = aws_kms_key.vault.id
}

output "vault_iam_user_name" {
  description = "The name of the Vault IAM user"
  value       = aws_iam_user.vault_user.name
}

output "vault_iam_user_access_key_id" {
  description = "The access key ID for the Vault IAM user"
  value       = aws_iam_access_key.vault_user_key.id
}

output "vault_iam_user_secret_access_key" {
  description = "The secret access key for the Vault IAM user"
  value       = aws_iam_access_key.vault_user_key.secret
  sensitive   = true
}