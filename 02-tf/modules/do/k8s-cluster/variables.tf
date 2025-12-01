variable "env" {
  description = "The environment for the Kubernetes cluster"
  type        = string
}

variable "service" {
  description = "The service name for the Kubernetes cluster"
  type        = string
}

variable "do_region" {
  description = "DigitalOcean region for the Kubernetes cluster"
  type        = string
  default     = "sfo2"
}

variable "k8s_version" {
  description = "Kubernetes version for the cluster"
  type        = string
  default     = "1.33.1-do.2"
}

variable "node_size" {
  description = "DO node size - see slugs.do-api.dev"
  type = string
  default = "s-1vcpu-2gb"
}

variable "node_count_min" {
  description = "Minimum number of nodes in the Kubernetes cluster"
  type    = number
}

variable "node_count_max" {
  description = "Maximum number of nodes in the Kubernetes cluster"
  type    = number
}

variable "vpc_id" {
  description = "VPC ID for the Kubernetes cluster"
  type        = string
}