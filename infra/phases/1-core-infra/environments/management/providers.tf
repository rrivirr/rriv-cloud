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
