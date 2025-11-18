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
      infra-phase = "1-core-infra"
    }
  }
}
