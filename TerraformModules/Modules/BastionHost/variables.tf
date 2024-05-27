variable "prefix" {}
variable "environment-short" {}
variable "location-short" {}
variable "location" {}
variable "resource-group-name" {}
variable "subnet-id" {}
variable "publicip-id" {}
variable "tags"{
    type = map(any)
    default = {}
}