terraform {
  required_version = "1.8.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.24.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }

    external = {
      source  = "hashicorp/external"
      version = "~> 2.3.3"
    }
  }
}
