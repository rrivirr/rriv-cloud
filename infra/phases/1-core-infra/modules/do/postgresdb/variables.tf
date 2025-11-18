variable "env" {
  type        = string
  description = "The environment"
}

variable "vpc_id" {
  description = "VPC ID for the database cluster"
  type        = string
}
