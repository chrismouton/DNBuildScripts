module "virtual_network_subnet" {
    source = "../../Modules/VNetSubnet"

    subnet-name             = "AzureBastionSubnet"
    resource-group-name     = var.resource-group-name
    vnet-name               = var.vnet-name
    subnet-address-prefixes = var.subnet-address-prefixes
}

module "network_interface" {
    source = "../../Modules/NetworkInterface"

    prefix              = var.prefix
    location            = var.location
    location-short      = var.location-short
    environment-short   = var.environment-short
    resource-group-name = var.resource-group-name

    resource-name       = "bastion"

    subnet-id           = var.internal-subnet-id
}

#Create Azure Network Security Group With The Appropriate Security Rules
resource "azurerm_network_security_group" "nsg-bastionvm" {
    name                          = "nsg-bastionvm"
    location                      = var.location
    resource_group_name           = var.resource-group-name

    security_rule {
        name                       = "AllowHttpsInbound"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowGatewayManagerInbound"
        priority                   = 130
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowAzureLoadBalancerInbound"
        priority                   = 140
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowBastionHostCommunication1"
        priority                   = 150
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     ="8080"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowBastionHostCommunication2"
        priority                   = 160
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     ="5701"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowSshRdpOutbound1"
        priority                   = 100
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     ="22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
    }


    security_rule {
        name                       = "AllowSshRdpOutbound2"
        priority                   = 110
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     ="3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
    }

    security_rule {
        name                       = "AllowAzureCloudOutbound"
        priority                   = 120
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
    }

    security_rule {
        name                       = "AllowBastionCommunication1"
        priority                   = 130
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
    }

    security_rule {
        name                       = "AllowBastionCommunication2"
        priority                   = 140
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range    = "5701"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
    }

    security_rule {
        name                       = "AllowGetSessionInformation"
        priority                   = 150
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "Internet"
    }

}

#Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsgassoc" {
    network_interface_id      = module.network_interface.network-interface-id
    network_security_group_id = azurerm_network_security_group.nsg-bastionvm.id
    
}

module "virtual_machine" {
    source = "../../Modules/VirtualMachine"

    location             = var.location
    resource-group-name  = var.resource-group-name
    resource-name        = "bastion"
    vm-size              = var.vm-size
    vm-admin-username    = var.vm-admin-username
    vm-admin-password    = var.vm-admin-password
    network-interface-id = module.network_interface.network-interface-id
}

module "public_ip" {
    source = "../../Modules/PublicIP"

    prefix              = var.prefix
    location            = var.location
    location-short      = var.location-short
    environment-short   = var.environment-short
    resource-group-name = var.resource-group-name
}

module "bastion_host" {
    source = "../../Modules/BastionHost"

    prefix              = var.prefix
    location            = var.location
    location-short      = var.location-short
    environment-short   = var.environment-short
    resource-group-name = var.resource-group-name
    subnet-id           = module.virtual_network_subnet.subnet-id
    publicip-id         = module.public_ip.publicip-id
}