variable "prefix" {}
variable "environment-short" {}
variable "location-short" {}
variable "location" {}
variable "resource-group-name" {}
variable "vnet_subnet_id" {}
variable "dns-prefix" {}
variable "windows-admin-username" {}
variable "windows-admin-password" {}
variable "node-pool-name" {}
variable "cluster-node-count" {}
variable "vm-size" {
    default = "Standard_D2_v2"
}
variable "tags" {
    type = map(any)
    default = {}
}
variable "service-principal-client-id" {
    default = "00000000-0000-0000-0000-000000000000"
}
variable "service-principal-client-secret" {
    default = "00000000000000000000000000000000"
}