# Resource Groups per VNet
resource "azurerm_resource_group" "rg_spoke" {
  for_each = var.vnets

  name     = "rg-${each.value.name}-${var.product_name}"
  location = var.location

  tags = {
    source = "terraform"
  }
}

# VNets
resource "azurerm_virtual_network" "vnet_spoke" {
  for_each = var.vnets

  name                = "vnet-${each.value.name}-${var.product_name}"
  address_space       = each.value.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_spoke[each.key].name

  tags = {
    source = "terraform"
  }
}

# Flatten subnets to a single map for iteration
locals {
  subnets_flat = tomap({
    for pair in flatten([
      for vnet_key, v in var.vnets : [
        for sname, s in v.subnets : {
          key   = "${vnet_key}-${sname}"
          value = {
            vnet_key         = vnet_key
            name             = sname
            address_prefixes = s.address_prefixes
          }
        }
      ]
    ]) : pair.key => pair.value
  })
}

# Subnets (separate resource; more reliable than inline definition)
resource "azurerm_subnet" "subnet" {
  for_each = local.subnets_flat

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg_spoke[each.value.vnet_key].name
  virtual_network_name = azurerm_virtual_network.vnet_spoke[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
}

# Example NSGs per VNet (optional)
resource "azurerm_network_security_group" "nsg" {
  for_each = var.vnets

  name                = "nsg-${each.value.name}-${var.product_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_spoke[each.key].name

  security_rule {
    name                       = "allow_vnet_inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "allow_vnet_outbound"
    priority                   = 150
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = {
    source = "terraform"
  }
}

# Associate all subnets to the corresponding VNet NSG (optional)
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each = local.subnets_flat

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.vnet_key].id
}
