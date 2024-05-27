resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.prefix}-${var.environment-short}"
  address_space       = ["${var.address-space}"]
  location            = var.location
  resource_group_name = var.resource-group-name
}