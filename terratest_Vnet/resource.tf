provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "vnet-rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "vnet-nsg" {
  name                = var.nsg
   resource_group_name = azurerm_resource_group.vnet-rg.name
  location = azurerm_resource_group.vnet-rg.location
}

resource "azurerm_virtual_network" "vnet" {
  name = "var.vnet_${var.postfix}"
  resource_group_name = azurerm_resource_group.vnet-rg.name
  location = azurerm_resource_group.vnet-rg.location
  address_space       = [var.vnet_adress_spaces]
}

resource  "azurerm_subnet" "new-subnet" {
  name = var.subnet-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.vnet-rg.name
  address_prefixes = [var.subnet_adress_prefixes]
}
