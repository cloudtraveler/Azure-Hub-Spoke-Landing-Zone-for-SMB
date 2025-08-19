# Output: Subnet IDs
# 출력: Subnet 리소스들의 ID
output "subnet_ids" {
  value       = { for v in azurerm_virtual_network.vnet-spoke : v.name => [for s in v.subnet : s.id] }
  description = "The IDs of the subnets" # 서브넷들의 ID
}

# Output: NSG IDs
# 출력: Network Security Group(NSG)들의 ID
output "nsg_ids" {
  value       = { for n in azurerm_network_security_group.nsg : n.name => n.id }
  description = "The IDs of the NSGs" # NSG들의 ID
}

# Output: VNet IDs
# 출력: Spoke VNet들의 ID
output "vnet_spoke_ids" {
  value       = { for v in azurerm_virtual_network.vnet-spoke : v.name => v.id }
  description = "The IDs of the spoke VNets" # Spoke VNet들의 ID
}

# Output: Resource Group IDs
# 출력: Resource Group들의 ID
output "resource_group_ids" {
  value       = { for r in azurerm_resource_group.rg-spoke : r.name => r.id }
  description = "The IDs of the resource groups" # 리소스 그룹들의 ID
}

# Output: Product Name
# 출력: Product Name 변수 값
output "product-name" {
  value       = var.product_name
  description = "The product name" # 제품/프로젝트 이름
}
