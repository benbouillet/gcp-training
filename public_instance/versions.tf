terraform {
  required_version = "~> 1.7"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.24"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
