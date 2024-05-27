module "kubernetes_cluster" {
    source = "../../Modules/KubernetesCluster"

    prefix              = var.prefix
    location            = var.location
    location-short      = var.location-short
    environment-short   = var.environment-short
    resource-group-name = var.resource-group-name
    vnet_subnet_id      = var.internal-subnet-id
    windows-admin-username = var.windows-admin-username
    windows-admin-password = var.windows-admin-password 
    dns-prefix          = var.dns-prefix
    node-pool-name      = var.node-pool-name
    cluster-node-count  = var.cluster-node-count
    vm-size             = var.vm-size
}

#Need to do a bit of work to associate ACR to AKS. It is not a link!
#That drove me nuts and waisted HOURS. Read the following blog post
#that will provide details to grant permission for AKS <--> ACR:
#https://gaunacode.com/azure-container-registry-and-aks-with-terraform
