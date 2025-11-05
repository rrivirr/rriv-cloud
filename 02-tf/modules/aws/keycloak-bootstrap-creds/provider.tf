terraform {
  required_version = ">= 1.12.1"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">=3.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }
}
