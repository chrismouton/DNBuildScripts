resource "azurerm_public_ip" "main" {
  name                = "pip-${var.prefix}-${var.environment-short}-${var.location-short}"
  location            = var.location
  resource_group_name = var.resource-group-name
  allocation_method   = var.allocation-method
  sku                 = var.sku
}