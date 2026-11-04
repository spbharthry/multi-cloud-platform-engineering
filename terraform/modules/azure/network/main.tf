resource "azurerm_virtual_network" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = merge(var.tags, { ManagedBy = "Terraform", Component = "network" })
}
resource "azurerm_network_security_group" "subnet" {
  for_each            = var.subnets
  name                = "${var.name}-${each.key}-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, { ManagedBy = "Terraform", Component = "network" })
  # Azure default NSG rules apply. No custom inbound internet allow rules.
}
resource "azurerm_subnet" "this" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.subnet[each.key].id
}
