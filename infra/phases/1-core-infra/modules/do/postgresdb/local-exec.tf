# TODO: figure this out
# resource "null_resource" "pg_permissions" {
#   count = 2
#   provisioner "local-exec" {
#     command = "${path.module}/scripts/keycloak-permissions.sh ${count.index == 0 ? "vault" : "rriv"} ${var.env}"
#   }
# }