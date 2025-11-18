variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-west-1"
}

variable "domain_name" {
  type = string
  description = "Domain name, ie rriv.org"
}