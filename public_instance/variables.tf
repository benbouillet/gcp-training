variable "name" {
  description = "A unique name for the resource"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "machine_type" {
  description = "The machine type to create"
  type        = string
}

variable "image_project_id" {
  description = "ID of the project owning the image family"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "image_family" {
  description = "The name of an image family that will define the corresponding image"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "zone" {
  description = "The zone that the machine should be created in. If it is not provided, the provider zone is used."
  type        = string
}

variable "network_tags" {
  description = "A list of network tags to attach to the instance"
  type        = list(string)
}

variable "network_self_link" {
  description = "Name or self_link of the network to attach the instance interface to"
  type        = string
}

variable "subnetwork_self_link" {
  description = "Name or self_link of the subnetwork to attach the instance interface to"
  type        = string
}

variable "boot_disk_auto_delete" {
  description = "Whether the disk will be auto-deleted when the instance is deleted"
  type        = bool
  default     = true
}

variable "boot_disk_size" {
  description = "The size of the image in gigabytes"
  type        = number
  nullable    = true
}

variable "user" {
  description = "User name used to connect to the instance via SSH"
  type        = string
}
