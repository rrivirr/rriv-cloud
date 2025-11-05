variable "env" {
  description = "The environment for which the Keycloak realm is being created (e.g., staging, prod)."
  type        = string
}

variable "smtp_username" {
  description = "SMTP username for Keycloak email configuration."
  type        = string
}

variable "smtp_password" {
  description = "SMTP password for Keycloak email configuration."
  type        = string
}

variable "domain" {
  description = "The domain for rriv"
  type        = string
  default     = "rriv.org"
}