resource "random_pet" "stack" {}

data "google_compute_zones" "available" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

data "http" "local_ipv4" {
  url = "https://api.ipify.org"
}

locals {
  local_ipv4 = data.http.local_ipv4.response_body
  stack_name = random_pet.stack.id
}
