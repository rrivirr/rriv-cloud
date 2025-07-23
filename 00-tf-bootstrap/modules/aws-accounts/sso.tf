data "aws_ssoadmin_instances" "rriv" {
  region = var.aws_region
}

# SSO Users
resource "aws_identitystore_user" "kat" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.rriv.identity_store_ids)[0]

  display_name = "Kat Leipper"
  user_name    = "kat"

  name {
    given_name  = "Kat"
    family_name = "Leipper"
  }

  emails {
    value = "kat@rriv.org"
    primary = true
  }
}

# Account Assignments
resource "aws_ssoadmin_account_assignment" "rriv-dev_kat" {
  instance_arn = tolist(data.aws_ssoadmin_instances.rriv.arns)[0]
  principal_id = aws_identitystore_user.kat.user_id
  principal_type = "USER"
  target_id = aws_organizations_account.dev.id
  target_type = "AWS_ACCOUNT"

  permission_set_arn = aws_ssoadmin_permission_set.admin.arn
}

resource "aws_ssoadmin_account_assignment" "rriv-staging_kat" {
  instance_arn = tolist(data.aws_ssoadmin_instances.rriv.arns)[0]
  principal_id = aws_identitystore_user.kat.user_id
  principal_type = "USER"
  target_id = aws_organizations_account.staging.id
  target_type = "AWS_ACCOUNT"

  permission_set_arn = aws_ssoadmin_permission_set.admin.arn
}

resource "aws_ssoadmin_account_assignment" "rriv-prod_kat" {
  instance_arn = tolist(data.aws_ssoadmin_instances.rriv.arns)[0]
  principal_id = aws_identitystore_user.kat.user_id
  principal_type = "USER"
  target_id = aws_organizations_account.prod.id
  target_type = "AWS_ACCOUNT"

  permission_set_arn = aws_ssoadmin_permission_set.admin.arn
}

# Permission Sets
resource "aws_ssoadmin_permission_set" "admin" {
  name        = "AdministratorAccess"
  description = "Admin access for rriv accounts"
  instance_arn = tolist(data.aws_ssoadmin_instances.rriv.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.rriv.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn
}