locals {
  bastion_name = format("%s-bastion", "mysql")
  bastion_zone = format("%s-a", var.region)
}

data "template_file" "startup_script" {
  template = <<-EOF
  sudo apt install -y wget
  sudo apt-get -y update 
  sudo apt-get -y install aptitude
  sudo aptitude -y install mariadb-server
  sudo service mysqld stop
  sudo apt-get -y update && \
  wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy && \
  chmod +x cloud_sql_proxy
  EOF
}

module "bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "~> 5.0"

  network        = var.vpc_network
  subnet         = var.subnet_name
  project        = var.project_id
  host_project   = var.shared_host_project_id
  name           = local.bastion_name
  zone           = local.bastion_zone
  image_project  = "debian-cloud"
  machine_type   = "g1-small"
  startup_script = data.template_file.startup_script.rendered
  shielded_vm    = "false"
  service_account_roles = var.service_account_roles
  scopes                = var.scopes
  depends_on =    [module.cloud-nat]
}
