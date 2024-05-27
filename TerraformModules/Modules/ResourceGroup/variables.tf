variable "environment-short" {}
variable "location" {}
variable "location-short" {}
variable "prefix" {}
variable "tags"{
    type = map(any)
    default = {}
}