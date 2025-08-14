module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 11.1"

  project_id   = var.project_id
  network_name = "vpc-test"
  routing_mode = "GLOBAL"

  auto_create_subnetworks = false

  subnets = [
    {
      subnet_name   = "subnet-test"
      subnet_ip     = "10.10.0.0/24"
      subnet_region = var.region
    }
  ]

  ingress_rules = [
    {
      name          = "allow-http"
      priority      = 1000
      source_ranges = ["0.0.0.0/0"]
      target_tags   = ["http"]
      allow = [{
        protocol = "tcp"
        ports    = ["80"]
      }]
    },
    {
      name          = "allow-ssh"
      priority      = 1000
      source_ranges = var.allowed_ssh_cidr
      target_tags   = ["ssh"]
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
    }
  ]
}
