variable "env" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "vpc_octet" {
  description = "Second octet for VPC IP range (10.X.0.0/16)"
  type        = number
  default     = 10
}
