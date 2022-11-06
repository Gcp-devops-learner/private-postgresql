
data "google_compute_network" "main" {
  name    = var.vpc_network
  project = var.shared_host_project_id
}

module "private-service-access" {
  source      = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  project_id  = var.shared_host_project_id
  vpc_network = data.google_compute_network.main.name
}


module "postgresql-db" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  name                 = var.db_name
  random_instance_name = true
  database_version     = "POSTGRES_9_6"
  project_id           = var.project_id
  zone                 = var.zone
  region               = var.region
  tier                 = "db-custom-1-3840"

  deletion_protection = false

  ip_configuration = {
    ipv4_enabled        = false
    private_network     = data.google_compute_network.main.self_link
    require_ssl         = true
    allocated_ip_range  = module.private-service-access.google_compute_global_address_name
    authorized_networks = var.authorized_networks
  }
  module_depends_on = [module.private-service-access.peering_completed]
}