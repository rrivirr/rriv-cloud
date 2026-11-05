resource "openfga_store" "permissions_store" {
  name = "RRIV Permissions Store"
}

output "openfga_store_id" {
  description = "ID of the OpenFGA store"
  value       = openfga_store.permissions_store.id
}