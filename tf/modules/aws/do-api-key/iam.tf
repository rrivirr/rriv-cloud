# DigitalOcean API key secrets policy

resource "aws_iam_policy" "vault_do_api_secrets_policy" {
  name        = "rriv-${var.env}-vault-do-api-secrets-policy"
  description = "Allow Vault to access DigitalOcean API key secrets"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = aws_secretsmanager_secret.do_api_key.arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "vault_do_api_secrets_policy_attachment" {
  user       = var.vault_iam_user_name
  policy_arn = aws_iam_policy.vault_do_api_secrets_policy.arn
}