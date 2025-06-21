resource "kubernetes_secret" "vault_aws_kms_key" {
  metadata {
    name      = "vault-aws-kms-key"
    namespace = "vault"
  }

  data = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }

  type = "Opaque"
}