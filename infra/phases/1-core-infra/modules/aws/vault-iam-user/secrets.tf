resource "aws_secretsmanager_secret" "vault_iam_user_access_keys" {
  name = var.iam_user_access_key_secret_name
  description = "IAM access key and secret key for the Vault IAM user in the ${var.env} environment"
}

resource "aws_secretsmanager_secret_version" "vault_iam_user_access_keys" {
  secret_id     = aws_secretsmanager_secret.vault_iam_user_access_keys.id
  secret_string = jsonencode({
    access_key_id     = aws_iam_access_key.vault_user_key.id
    secret_access_key = aws_iam_access_key.vault_user_key.secret
  })
}

resource "aws_secretsmanager_secret" "vault_kms_key" {
  name  = "rriv-${var.env}-vault-kms-key-id"
  description = "KMS key ID for the Vault root encryption key in the ${var.env} environment"
}

resource "aws_secretsmanager_secret_version" "vault_kms_key" {
  secret_id     = aws_secretsmanager_secret.vault_kms_key.id
  secret_string = jsonencode({
    key_id = aws_kms_key.vault.id
  })
}
