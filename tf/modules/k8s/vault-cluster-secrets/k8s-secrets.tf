resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "kubernetes_secret" "vault_aws_access_key" {
  metadata {
    name      = "vault-aws-access-key"
    namespace = "vault"
  }

  data = {
    AWS_ACCESS_KEY_ID     = local.vault_iam_user_access_key_id
    AWS_SECRET_ACCESS_KEY = local.vault_iam_user_secret_access_key
  }

  type = "Opaque"
}

resource "kubernetes_secret" "vault_aws_kms_key" {
  metadata {
    name      = "vault-aws-kms-key"
    namespace = "vault"
  }

  data = {
    KMS_KEY_ID = local.vault_kms_key_id
  }

  type = "Opaque"
}

resource "kubernetes_secret" "do_api_token" {
  metadata {
    name      = "${var.env}-digitalocean-api-key"
    namespace = "cert-manager"
  }
  data = {
    api-token = var.do_token
  }
  type = "Opaque"
}

resource "kubernetes_secret" "letsencrypt_ca_cert" {
  metadata {
    name      = "${var.env}-letsencrypt-ca-cert"
    namespace = "vault"
  }

  data = {
    "ca.crt" = local_file.letsencrypt_ca_cert.content
  }

  type = "Opaque"
}

resource "local_file" "letsencrypt_ca_cert" {
  content  = file("${path.module}/static/letsencrypt-ca.crt")
  filename = "${path.module}/static/letsencrypt-ca.crt"
}

