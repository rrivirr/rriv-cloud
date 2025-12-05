terraform {
  required_version = ">= 1.12.1"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.47.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }

  backend "s3" {
    bucket = "rriv-cloud-management" 
    key    = "backend.tfstate"
    endpoints = {
      s3 = "https://sfo2.digitaloceanspaces.com"
    }

    region = "us-east-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

provider "digitalocean" {
  alias = "management-sfo2"
  token = var.do_token
}

provider "digitalocean" {
  alias = "dev-sfo2"
  token = var.dev_do_token
}

provider "digitalocean" {
  alias = "staging-sfo2"
  token = var.staging_do_token
}

provider "digitalocean" {
  alias = "prod-sfo2"
  token = var.prod_do_token
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
