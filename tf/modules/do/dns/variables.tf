variable "env" {
  description = "The environment for the DNS module"
  type        = string
}

variable "domain" {
  description = "The domain for the Kubernetes cluster"
  type        = string
  default     = "rriv.org"
}
