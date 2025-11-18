output "vpc_id" {
  value       = digitalocean_vpc.rriv.id
  description = "VPC ID"
}

output "vpc_urn" {
  value       = digitalocean_vpc.rriv.urn
  description = "VPC URN"
}
