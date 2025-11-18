variable "do_token" {
  description = "DigitalOcean API token with write permissions"
  type        = string
  sensitive   = true
}

variable "admin_ip" {
  description = "Admin IP address for SSH access to the droplet"
  type        = string
}

variable "admin_email" {
  description = "Email address for the admin SSH user"
  type        = string
  default     = "admin@rriv.org"
}

variable "ssh_key_public" {
  description = "Public SSH key content for VPN admin access"
  type        = string
}

variable "oidc_issuer" {
  description = "OIDC issuer URL for Headscale authentication - use prod URL"
  type        = string
}

variable "oidc_client_secret" {
  description = "OIDC client secret for Headscale"
  type        = string
  sensitive   = true
}

variable "oidc_client_id" {
  description = "OIDC client ID for Headscale"
  type        = string
  default     = "headscale"
}

variable "image_name" {
  description = "Name for the Packer-built DigitalOcean image"
  type        = string
  default     = "rriv-headscale-base-latest"
}

variable "droplet_image" {
  description = "DigitalOcean droplet image slug"
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "droplet_size" {
  description = "DigitalOcean droplet size slug"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "region" {
  description = "DigitalOcean region for the droplet"
  type        = string
  default     = "sfo2"
}

variable "gated_services" {
  description = "List of services to be accessible via the VPN"
  type = list(object({
    dns = string
    ip  = string
  }))
  default = []
}