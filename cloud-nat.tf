module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "~> 1.2"
  router        = var.router_name
  project_id    = var.shared_host_project_id
  region        = var.region
  create_router = true
  network       = var.vpc_network
}