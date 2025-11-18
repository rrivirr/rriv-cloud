provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      account     = "rriv"
      iac         = "terraform"
      repo        = "github.com/rrivirr/rriv-cloud"
      region      = var.aws_region
      infra-phase = "0-bootstrap-aws"
    }
  }
}
