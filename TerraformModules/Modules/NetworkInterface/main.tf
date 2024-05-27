resource "azurerm_network_interface" "main" {
  name                = "nic-${var.prefix}-${var.environment-short}-${var.location-short}-${var.resource-name}"
  resource_group_name = var.resource-group-name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet-id
    private_ip_address_allocation = var.private-ip-address-allocation
  }
}