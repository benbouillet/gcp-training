terraform {
  backend "gcs" {
    prefix = "terraform/gcp-training/"
  }
}
