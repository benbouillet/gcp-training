terraform {
  required_version = "1.7.5"

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

    http = {
      source  = "hashicorp/http"
      version = "3.4.2"
    }
  }
}
