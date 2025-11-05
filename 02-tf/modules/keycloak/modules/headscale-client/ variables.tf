variable "domain" {
  description = "The domain for rriv"
  type        = string
  default     = "rriv.org"
}

variable "realm_id" {
  description = "The Keycloak realm ID where the client will be created."
  type        = string
}