data "digitalocean_droplet_snapshot" "headscale_base_image" {
  name_regex  = "rriv-headscale-base-.*"
  region      = "sfo2"
  most_recent = true
}