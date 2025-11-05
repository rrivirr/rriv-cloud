data "aws_caller_identity" "current" {
  # This data source retrieves the current AWS account ID
}

resource "aws_kms_key" "vault" {
  description             = "Vault root key for ${var.env}"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = {
    Name = "rriv-dev-vault"
    last-updated = timestamp()
    last-updated-by = data.aws_caller_identity.current.user_id
  }

  lifecycle {
    ignore_changes = [
      tags["last-updated"],
      tags["last-updated-by"]
    ]
  }
}

resource "aws_kms_alias" "vault" {
  name          = var.kms_key_alias
  target_key_id = aws_kms_key.vault.id
}

resource "aws_kms_key_policy" "vault" {
  key_id = aws_kms_key.vault.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Allow root user to manage key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow Vault to use the key"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.vault_user.arn
        },
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ],
        Resource = "*"
      }
    ]
  })
}