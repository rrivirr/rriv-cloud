variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "do_token_rriv_cert_manager" {
  type        = string
  description = "DigitalOcean API token scoped for domain read/update only. Used by rriv cluster for creating cert-manager resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-west-1"
}

variable "vault_token" {
  description = "Terraform admin temporary token from vault-kubernetes.sh"
  type        = string
}
