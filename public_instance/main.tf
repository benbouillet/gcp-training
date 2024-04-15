data "google_project" "this" {
}

data "google_compute_image" "this" {
  project = var.image_project_id
  family  = var.image_family

  most_recent = true
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "google_kms_key_ring" "this" {
  name     = "${var.name}-keyring"
  location = var.region
}

resource "google_kms_crypto_key" "this" {
  name     = "${var.name}-key"
  key_ring = google_kms_key_ring.this.id
}

resource "google_kms_crypto_key_iam_binding" "ph-key-compute-binding" {
  crypto_key_id = google_kms_crypto_key.this.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:service-${data.google_project.this.number}@compute-system.iam.gserviceaccount.com"
  ]
}

resource "google_service_account" "this" {
  account_id   = "${var.name}-sa"
  display_name = "${var.name} Service Account"
}

resource "google_compute_instance" "this" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  service_account {
    email  = google_service_account.this.email
    scopes = ["cloud-platform"]
  }
  tags = var.network_tags

  network_interface {
    network    = var.network_self_link
    subnetwork = var.subnetwork_self_link
    access_config {}
  }

  boot_disk {
    auto_delete = var.boot_disk_auto_delete
    initialize_params {
      image = data.google_compute_image.this.self_link
      size  = var.boot_disk_size
    }
    # https://avd.aquasec.com/misconfig/google/compute/avd-gcp-0033/
    kms_key_self_link = google_kms_crypto_key.this.id
  }

  metadata = {
    ssh-keys = "${var.user}:${tls_private_key.this.public_key_openssh}"
    # https://avd.aquasec.com/misconfig/google/compute/avd-gcp-0030/
    block-project-ssh-keys = true
  }

  metadata_startup_script = "echo hi > /test.txt"

  # https://avd.aquasec.com/misconfig/google/compute/avd-gcp-0041/
  # https://avd.aquasec.com/misconfig/google/compute/avd-gcp-0045/
  # https://avd.aquasec.com/misconfig/avd-gcp-0067
  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
    enable_secure_boot          = true
  }
}
