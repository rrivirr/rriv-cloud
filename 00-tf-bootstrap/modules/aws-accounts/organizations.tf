resource "aws_organizations_account" "dev" {
  name      = "rriv-dev"
  email     = "dev@rriv.org"

  tags = {
    environment = "dev"
  }
}

resource "aws_organizations_account" "staging" {
  name      = "rriv-staging"
  email     = "staging@rriv.org"

  tags = {
    environment = "staging"
  }
}

resource "aws_organizations_account" "prod" {
  name      = "rriv-prod"
  email     = "prod@rriv.org"

  tags = {
    environment = "prod"
  }
}
