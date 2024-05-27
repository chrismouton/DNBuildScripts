# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

module "resource_group" {
    source = "../TerraformModules/Modules/ResourceGroup"

    prefix            = var.prefix
    location          = var.location
    location-short    = var.location-short
    environment-short = var.environment-short
    tags              = var.tags
}

module "virtual_network" {
    source = "../TerraformModules/Modules/VirtualNetwork"

    prefix              = var.prefix
    location            = var.location
    environment-short   = var.environment-short
    resource-group-name = module.resource_group.resource-group-name
    address-space       = var.address-space
}

module "virtual_network_subnet" {
    source = "../TerraformModules/Modules/VNetSubnet"

    subnet-name             = "internal"
    resource-group-name     = module.resource_group.resource-group-name
    vnet-name               = module.virtual_network.virtual-network-name
    subnet-address-prefixes = "40.0.2.0/24"
}

module "bastion" {
  source = "../TerraformModules/Services/Bastion"

    prefix                  = var.prefix
    location                = var.location
    location-short          = var.location-short
    environment-short       = var.environment-short
    resource-group-name     = module.resource_group.resource-group-name
    vnet-name               = module.virtual_network.virtual-network-name
    subnet-address-prefixes = "40.0.1.0/24"
    internal-subnet-id      = module.virtual_network_subnet.subnet-id
    vm-size                 = "Standard_A2_v2"
    vm-admin-username       = var.vm-admin-username
    vm-admin-password       = var.vm-admin-password
    tags                    = var.tags

}

module "container_instance" {
    source = "../TerraformModules/Services/ContainerInstance"

    prefix            = var.prefix
    location          = var.location
    location-short    = var.location-short
    environment-short = var.environment-short
    tags              = var.tags

    resource-group-name = module.resource_group.resource-group-name
    vnet-name           = module.virtual_network.virtual-network-name

    internal-subnet-id = module.virtual_network_subnet.subnet-id
    windows-admin-username = var.k8s-admin-username
    windows-admin-password = var.k8s-admin-password
    dns-prefix = "hydra-sit"
    node-pool-name = "nodepool1"
    cluster-node-count = 3
    vm-size = "Standard_E4s_v5"
}