variable "environment-short" {}
variable "location" {}
variable "location-short" {}
variable "prefix" {}
variable "resource-group-name" {}
variable "vnet-name" {}
variable "subnet-address-prefixes" {}
variable "internal-subnet-id" {}
variable "vm-size" {}
variable "vm-admin-username" {}
variable "vm-admin-password" {}
variable "tags"{
    type = map(any)
    default = {}
}