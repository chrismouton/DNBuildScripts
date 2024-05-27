resource "azurerm_bastion_host" "main" {
  name                = "bh-${var.prefix}-${var.environment-short}-${var.location-short}"
  location            = var.location
  resource_group_name = var.resource-group-name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet-id
    public_ip_address_id = var.publicip-id
  }

  tags                   = var.tags
}