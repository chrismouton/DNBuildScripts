resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.prefix}-${var.environment-short}-${var.location-short}"
  location            = var.location
  resource_group_name = var.resource-group-name
  dns_prefix          = var.dns-prefix

  network_profile {
    load_balancer_sku = "standard"
    network_plugin = "azure"
  }

  windows_profile {
    admin_username = var.windows-admin-username
    admin_password = var.windows-admin-password
  }

  default_node_pool {
    name = var.node-pool-name
    node_count = var.cluster-node-count
    vm_size = var.vm-size
    vnet_subnet_id = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}