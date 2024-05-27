resource "azurerm_windows_virtual_machine" "main" {
  name                            = "vm-${var.resource-name}"
  resource_group_name             = var.resource-group-name
  location                        = var.location
  size                            = var.vm-size
  admin_username                  = var.vm-admin-username
  admin_password                  = var.vm-admin-password
  network_interface_ids           = ["${var.network-interface-id}"]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}