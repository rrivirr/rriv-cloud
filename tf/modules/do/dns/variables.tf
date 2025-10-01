variable "env" {
  description = "The environment that the DNS records are in"
  type        = string
}

variable "rriv_org_lb_ip" {
  description = "The load balancer IP address for [env.]rriv.org"
  type        = string
}

variable "chirp_lb_ip" {
  description = "The load balancer IP address for chirpstack"
  type        = string
}

variable "chirp_console_lb_ip" {
  description = "The load balancer IP address for chirp-console"
  type        = string
}

variable "vault_lb_ip" {
  description = "The load balancer IP address for vault"
  type        = string
}