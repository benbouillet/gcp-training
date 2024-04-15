output "public_ip" {
  value = flatten(google_compute_instance.this.network_interface[*].access_config[*].nat_ip)
}

output "private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}
