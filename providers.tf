data "external" "git" {
  program = ["sh", "-c", <<-EOSCRIPT
    https_url=$(git remote get-url origin | sed -E 's#^.*(git.*\..{2,3}):#\1/#g;s#\.git$##g;s#[\/\.]#_#g')
    echo "{\"https_url\": \"$https_url\"}"
  EOSCRIPT
  ]
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region

  default_labels = {
    technical_owner = var.technical_owner
    project_owner   = var.project_owner
    project_name    = var.project_name
    environment     = var.environment
    client_name     = var.client_name
    iac_repository  = data.external.git.result.https_url
  }
}
