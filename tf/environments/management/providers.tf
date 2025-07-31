terraform {
  required_version = ">= 1.12.1"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.53.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }

  # See backend.hcl.example
  # Use the backend file with the command:
  # terraform init -backend-config=backend.hcl

  backend "s3" {
    bucket = "" 
    key    = ""
    region = ""
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region = var.aws_region
  alias  = "dev-us-west-1"

  default_tags {
    tags = {
      environment = "dev"
      account     = "rriv-dev"
      iac         = "terraform"
      repo        = "github.com/rrivirr/rriv-cloud"
      region      = var.aws_region
    }
  }
}
