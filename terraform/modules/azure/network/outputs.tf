output "vnet_id" { value = azurerm_virtual_network.this.id }
output "subnet_ids" { value = { for k, v in azurerm_subnet.this : k => v.id } }
output "nsg_ids" { value = { for k, v in azurerm_network_security_group.subnet : k => v.id } }
