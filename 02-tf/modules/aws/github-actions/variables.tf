variable "env" {
  type        = string
  description = "Environment name"
}

variable "github_repos" {
  type        = list(string)
  description = "List of GitHub repositories to allow access for GitHub Actions"
  default     = ["rrivirr/rriv-cloud", "rrivirr/github-actions", "rrivirr/rriv-api", "rrivirr/data-api"]
}

variable "secret_github_actions_do_api_key_arn" {
  description = "Secrets Manager ARN for DigitalOcean API token that allows access to k8s, used by GitHub Actions"
  type        = string
  sensitive   = true
}
