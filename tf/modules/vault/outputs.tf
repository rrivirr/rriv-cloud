output "kat_password" {
  value = random_password.kat_password.result
  sensitive = true
}

output "zaven_password" {
  value = random_password.zaven_password.result
  sensitive = true
}