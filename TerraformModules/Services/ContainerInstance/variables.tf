variable "environment-short" {}
variable "location" {}
variable "location-short" {}
variable "prefix" {}

variable "resource-group-name" {}
variable "vnet-name" {}

variable "internal-subnet-id" {}
variable "windows-admin-username" {}
variable "windows-admin-password" {}
variable "dns-prefix" {}
variable "node-pool-name" {}
variable "cluster-node-count" {}
variable "vm-size" {
    default = "Standard_A2_v2"
}

variable "tags"{
    type = map(any)
    default = {}
}