# Azure VNet network module

Creates one VNet, named subnets and an NSG per subnet with subnet associations. The calling environment creates the resource group. Azure's default NSG rules apply; add workload-specific ingress rules after threat review. No VMs, public IP addresses, or NAT gateways are created. **AzureRM 4.x** generally requires subscription ID configuration, even for offline initialization; see dev example.
