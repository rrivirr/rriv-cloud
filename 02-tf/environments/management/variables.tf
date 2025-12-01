variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "dev_do_token" {
  type        = string
  description = "DigitalOcean API token for the dev environment"
}

variable "staging_do_token" {
  type        = string
  description = "DigitalOcean API token for the staging environment"
}

variable "prod_do_token" {
  type        = string
  description = "DigitalOcean API token for the prod environment"
}

variable "ssh_admin_ip" {
  description = "Admin IP address for SSH access to the droplets"
  type        = string
}

variable "ssh_key_public" {
  description = "Public SSH key content for VPN admin access"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMcWzmZUYU3BSosiZ+rv9CH4RNcQNcqC7XbqtaIqXbCT admin@rriv.org"
}

variable "headscale_oidc_issuer" {
  description = "OIDC issuer URL for Headscale authentication"
  type        = string
  default     = "https://auth.dev.rriv.org/realms/rriv-beta-dev"
}

variable "headscale_oidc_client_id" {
  description = "OIDC client ID for Headscale"
  type        = string
  default     = "headscale"
}

variable "headscale_oidc_client_secret" {
  description = "OIDC client secret for Headscale"
  type        = string
  sensitive   = true
}

