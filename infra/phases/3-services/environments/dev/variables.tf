variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-west-1"
}

variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "vault_token" {
  description = "Terraform admin temporary token from vault-kubernetes.sh"
  type        = string
}

variable "keycloak_client_secret" {
  description = "Keycloak client secret for Terraform. Get this from Keycloak admin console upon initial login"
  type        = string
  sensitive   = true
  default     = ""
}