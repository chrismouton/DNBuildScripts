variable "environment-short" {}
variable "location" {}
variable "location-short" {}
variable "prefix" {}
variable "address-space" {}
variable "vm-admin-username" {}
variable "vm-admin-password" {}
variable "k8s-admin-username" {}
variable "k8s-admin-password" {}
variable "tags"{
    type = map(any)
    default = {}
}