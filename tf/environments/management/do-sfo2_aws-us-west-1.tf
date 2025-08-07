resource "digitalocean_domain" "do_sfo2_domain" {
  name = "${local.env}.rriv.io"
}