variable "env" {
  type        = string
  description = "Environment name"
}

variable "github_repos" {
  type        = list(string)
  description = "List of GitHub repositories to allow access for GitHub Actions"
  default     = [
		  "rrivirr@34754537/rriv-cloud@874947732", 
		  "rrivirr@34754537/github-actions@1030937088", 
		  "rrivirr@34754537/rriv-api@891702082", 
		  "rrivirr@34754537/data-api@1021193897", 
		  "rrivirr@34754537/rriv-chirpstack-web-hook",
      "rrivirr@34754537/rriv-auth-api@1301926462",
      "rrivirr@34754537/rriv-auth-model@1301927728",
      "rrivirr@34754537/rriv-web@1396520635"
		]
}

variable "secret_github_actions_do_api_key_arn" {
  description = "Secrets Manager ARN for DigitalOcean API token that allows access to k8s, used by GitHub Actions"
  type        = string
  sensitive   = true
}
