terraform {
  required_version = ">= 1.12.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }

  # Copy the access key & secret key from the rriv management account
  backend "s3" {
    bucket = "rriv-cloud-management"
    key    = "account-bootstrap.tfstate"
    region = "us-west-1"
  }
}