variable "prefix" {}
variable "environment-short" {}
variable "location-short" {}
variable "location" {}
variable "resource-group-name" {}
variable "allocation-method" {
    default = "Static"
}
variable "sku" {
    default = "Standard"
}