resource "azurerm_resource_group" "main" {
  name     = "rg-${var.prefix}-${var.environment-short}-${var.location-short}"
  location = var.location
}