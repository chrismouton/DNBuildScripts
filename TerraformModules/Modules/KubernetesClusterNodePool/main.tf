resource "azurerm_kubernetes_cluster_node_pool" "main" {
  name                  = var.node-pool-name
  kubernetes_cluster_id = var.kubernetes-cluster-id
  vm_size               = var.vm-size
  node_count            = var.cluster-node-count
  tags                  = var.tags
}