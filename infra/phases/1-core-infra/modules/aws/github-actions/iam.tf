resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_actions" {
  name = "rriv-${var.env}-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          "ForAnyValue:StringLike" = {
            "token.actions.githubusercontent.com:sub" = [
              for repo in var.github_repos : "repo:${repo}:*"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_attach" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.read_secret_github_actions_do_api_key.arn
}

resource "aws_iam_policy" "read_secret_github_actions_do_api_key" {
  name        = "rriv-${var.env}-read-do-github-actions-api-key"
  description = "Allow reading GitHub Actions DO API key from Secrets Manager"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = var.secret_github_actions_do_api_key_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_read_secret_attach" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.read_secret_github_actions_do_api_key.arn
}