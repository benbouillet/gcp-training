resource "google_compute_network" "vpc_network" {
  name                            = random_pet.stack.id
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}
