variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "dev_do_token" {
  type        = string
  description = "DigitalOcean API token for the dev environment"
}

variable "ssh_admin_ip" {
  description = "Admin IP address for SSH access to the droplets"
  type        = string
}

variable "ssh_key_public" {
  description = "Public SSH key content for VPN admin access"
  type        = string
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

