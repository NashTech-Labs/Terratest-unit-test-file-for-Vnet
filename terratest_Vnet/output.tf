output "resource_group" {
    value = azurerm_resource_group.vnet-rg.name
  
}
output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
  
}
output "new-subnet_name" {
    value = azurerm_subnet.new-subnet.name
  
}
output "vnet_id" {
    value = azurerm_virtual_network.vnet
}
