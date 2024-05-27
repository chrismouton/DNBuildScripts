variable "resource-group-name" {}
variable "location" {}
variable "prefix" {}
variable "environment-short" {}
variable "address-space" {
    default = "10.0.0.0/16"
}
