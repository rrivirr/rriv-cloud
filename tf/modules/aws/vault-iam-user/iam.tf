resource "aws_iam_user" "vault_user" {
  name = "rriv-${var.env}-vault-user"
}

resource "aws_iam_access_key" "vault_user_key" {
  user = aws_iam_user.vault_user.name
}

# KMS unseal policy

resource "aws_iam_policy" "vault_kms_policy" {
  name        = "rriv-${var.env}-vault-kms-policy"
  description = "Allow Vault to access KMS key for auto-unsealing"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:DescribeKey"
        ],
        Resource = aws_kms_key.vault.arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "vault_kms_policy_attachment" {
  user       = aws_iam_user.vault_user.name
  policy_arn = aws_iam_policy.vault_kms_policy.arn
}


# TLS cert secrets policy

# TODO: manage elswhere after helm is applied

# resource "aws_iam_policy" "vault_tls_secrets_policy" {
#   name        = "rriv-${var.env}-vault-tls-secrets-policy"
#   description = "Allow Vault to access TLS cert secrets"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = [
#           "secretsmanager:GetSecretValue",
#           "secretsmanager:DescribeSecret"
#         ],
#         Resource = var.vault_tls_cert_arn
#       }
#     ]
#   })
# }

# resource "aws_iam_user_policy_attachment" "vault_tls_secrets_policy_attachment" {
#   user       = aws_iam_user.vault_user.name
#   policy_arn = aws_iam_policy.vault_tls_secrets_policy.arn
# }


