resource "aws_organizations_account" "dev" {
  name      = "rriv-dev"
  email     = "dev@${var.domain_name}"

  tags = {
    environment = "dev"
  }
}

resource "aws_organizations_account" "staging" {
  name      = "rriv-staging"
  email     = "staging@${var.domain_name}"

  tags = {
    environment = "staging"
  }
}

resource "aws_organizations_account" "prod" {
  name      = "rriv-prod"
  email     = "prod@${var.domain_name}"

  tags = {
    environment = "prod"
  }
}
