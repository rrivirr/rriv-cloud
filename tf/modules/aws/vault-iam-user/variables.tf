variable "env" {
  type        = string
  description = "Environment name"
}

variable "iam_user_access_key_secret_name" {
  type        = string
  description = "The name of the AWS Secrets Manager secret that stores the Vault IAM user access keys"
}

variable "kms_key_alias" {
  type        = string
  description = "The alias of the KMS key used for Vault"
}