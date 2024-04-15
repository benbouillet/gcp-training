resource "google_compute_network" "vpc" {
  name                            = local.stack_name
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "public" {
  name          = "${local.stack_name}-public"
  ip_cidr_range = "10.2.0.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "ssh_to_instance_ipv4" {
  name    = "${local.stack_name}-allow-inbound-ipv4"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "${local.local_ipv4}/32"
  ]

  target_tags = [local.stack_name]
}
