resource "null_resource" "helm_install" {
  count = 2
  provisioner "local-exec" {
    command = "${path.module}/scripts/helm-install.sh ${count.index == 0 ? "vault" : "rriv"} ${var.env}"
  }
}