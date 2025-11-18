resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
    labels = {
      name = "vault"
    }
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

  lifecycle {
    ignore_changes = [
      data["AWS_ACCESS_KEY_ID"],
      data["AWS_SECRET_ACCESS_KEY"]
    ]
  }
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

  lifecycle {
    ignore_changes = [
      data["KMS_KEY_ID"]
    ]
  }
}

# Used by vault to create DNS TXT records for ACME DNS-01 challenge
resource "kubernetes_secret" "do_dns_api_token" {
  metadata {
    name      = "${var.env}-digitalocean-dns-api-key"
    namespace = "cert-manager"
  }
  data = {
    api-token = var.do_token_rriv_cert_manager
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

