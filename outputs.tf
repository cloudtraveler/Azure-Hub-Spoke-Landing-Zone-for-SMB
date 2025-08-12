output "vnet_spoke_ids" {
  description = "IDs of the spoke VNets"
  value       = { for k, v in azurerm_virtual_network.vnet_spoke : k => v.id }
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = { for k, s in azurerm_subnet.subnet : k => s.id }
}

output "nsg_ids" {
  description = "IDs of the NSGs"
  value       = { for k, n in azurerm_network_security_group.nsg : k => n.id }
}
