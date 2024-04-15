output "instance_public_ip" {
  value = module.public_instance.public_ip
}

output "instance_ssh_private_key" {
  value     = module.public_instance.private_key
  sensitive = true
}

output "instance_user" {
  value = var.instances_user
}
