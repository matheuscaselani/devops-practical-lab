locals {
  access_config = {
    nat_ip       = var.nat_ip
    network_tier = var.network_tier
  }
}

module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 13.0"
  depends_on = [ module.vpc ]

  region               = var.region
  project_id           = var.project_id
  subnetwork           = var.subnetwork
  subnetwork_project   = var.project_id
  access_config        = [local.access_config]
  stack_type           = "IPV4_ONLY"
  service_account      = var.service_account
  tags                 = var.tags
  disk_size_gb         = 10
  disk_type            = "pd-ssd"
  machine_type         = "n1-standard-1"
  auto_delete          = "true"
  source_image_project = "debian-cloud"
  source_image         = "debian-12"
  startup_script       = file("../scripts/startup.sh")
}

module "compute_instance" {
  source  = "terraform-google-modules/vm/google//modules/compute_instance"
  version = "~> 13.0"

  region              = var.region
  zone                = "${var.region}-b"
  num_instances       = var.num_instances
  hostname            = "idwall-vm-instance-test"
  instance_template   = module.instance_template.self_link
  deletion_protection = false
}