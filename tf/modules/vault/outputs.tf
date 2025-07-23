output "kat_password" {
  value = random_password.kat_password.result
  sensitive = true
}