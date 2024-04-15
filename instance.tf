module "public_instance" {
  source = "./public_instance/"

  name                  = "${random_pet.stack.id}-pub"
  machine_type          = "e2-micro"
  image_project_id      = "ubuntu-os-cloud"
  image_family          = "ubuntu-2204-lts"
  zone                  = data.google_compute_zones.available.names[0]
  network_tags          = [local.stack_name]
  network_self_link     = google_compute_network.vpc.self_link
  subnetwork_self_link  = google_compute_subnetwork.public.self_link
  boot_disk_auto_delete = true
  boot_disk_size        = 20
  user                  = var.instances_user
  region                = var.gcp_region
}
