module "network" {
  source     = "../../../modules/gcp/network"
  project_id = var.project_id
  name       = "portfolio-dev-vpc"
  region     = var.region
  subnets    = { apps = "10.30.1.0/24", data = "10.30.2.0/24" }
}
output "network_id" { value = module.network.network_id }
