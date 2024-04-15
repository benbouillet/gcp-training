variable "technical_owner" {
  description = ""
  type        = string
}

variable "project_owner" {
  description = ""
  type        = string
}

variable "project_name" {
  description = ""
  type        = string
}

variable "environment" {
  description = ""
  type        = string
}

variable "client_name" {
  description = ""
  type        = string
}

variable "gcp_project_id" {
  description = "Google Cloud Project"
  type        = string
}

variable "gcp_region" {
  description = "Default GCP Region"
  type        = string
}

variable "instances_user" {
  description = "Default user used to connect to the compute instances"
  type        = string
}
