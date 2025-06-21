variable "aws_access_key_id" {
  description = "The AWS access key ID for the Vault IAM user"
  type        = string
  sensitive   = true
}
variable "aws_secret_access_key" {
  description = "The AWS secret access key for the Vault IAM user"
  type        = string
  sensitive   = true
}