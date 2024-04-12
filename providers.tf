data "external" "git" {
  program = ["sh", "-c", <<-EOSCRIPT
    https_url=$(git config --get remote.origin.url | sed -E 's#^git@(.*):(.*)\.git$#https://\1/\2#;s#^https://(gitlab-ci-token:.*@)(.*)(\.git)+$#https://\2#')
    echo "{\"https_url\": \"$https_url\"}"
  EOSCRIPT
  ]
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone

  default_labels = {
    technical_owner = var.technical_owner
    project_owner   = var.project_owner
    project_name    = var.project_name
    environment     = var.environment
    client_name     = var.client_name
    iac_repository  = data.external.git.result.https_url
  }
}
