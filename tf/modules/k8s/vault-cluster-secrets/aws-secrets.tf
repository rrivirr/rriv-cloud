data "aws_secretsmanager_secret" "vault_iam_user_access_keys" {
  name = var.vault_iam_user_access_key_secret_name
}

data "aws_secretsmanager_secret_version" "vault_iam_user_access_keys" {
  secret_id = data.aws_secretsmanager_secret.vault_iam_user_access_keys.id
}

data "aws_kms_alias" "vault_kms_key" {
  name = "alias/rriv-${var.env}-vault"
}

locals {
  vault_iam_user_access_key_id     = jsondecode(data.aws_secretsmanager_secret_version.vault_iam_user_access_keys.secret_string)["access_key_id"]
  vault_iam_user_secret_access_key = jsondecode(data.aws_secretsmanager_secret_version.vault_iam_user_access_keys.secret_string)["secret_access_key"]
  vault_kms_key_id                  = data.aws_kms_alias.vault_kms_key.id
}