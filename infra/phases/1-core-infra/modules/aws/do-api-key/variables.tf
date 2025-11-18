variable "env" {
  type        = string
  description = "Environment name"
}

variable "do_dns_api_key" {
  description = "DigitalOcean DNS API key for Vault TLS certs"
  type        = string
  sensitive   = true
}

variable "do_github_actions_api_key" {
  description = "DigitalOcean API key for GitHub Actions"
  type        = string
  sensitive   = true
  default     = ""
}

variable "vault_iam_user_name" {
  description = "Name of the Vault IAM user"
  type        = string
}