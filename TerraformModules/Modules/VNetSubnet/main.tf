resource "azurerm_subnet" "main" {
  name                 = var.subnet-name
  resource_group_name  = var.resource-group-name
  virtual_network_name = var.vnet-name
  address_prefixes     = ["${var.subnet-address-prefixes}"]
}