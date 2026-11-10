output "app_id" {
  description = "ID of the App Platform app."
  value       = digitalocean_app.rriv_web.id
}

output "default_ingress" {
  description = "Default ondigitalocean.app URL."
  value       = digitalocean_app.rriv_web.default_ingress
}

output "live_url" {
  description = "Live URL of the app (custom domain if configured)."
  value       = digitalocean_app.rriv_web.live_url
}
