resource "azurerm_resource_group" "this" {
  name     = "rg-portfolio-network-dev"
  location = var.location
  tags     = { Environment = "dev", Project = "multi-cloud-platform-engineering" }
}
module "network" {
  source              = "../../../modules/azure/network"
  name                = "vnet-portfolio-dev"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.20.0.0/16"]
  subnets = {
    apps = { address_prefixes = ["10.20.1.0/24"] }
    data = { address_prefixes = ["10.20.2.0/24"] }
  }
  tags = { Environment = "dev", Project = "multi-cloud-platform-engineering" }
}
output "vnet_id" { value = module.network.vnet_id }
