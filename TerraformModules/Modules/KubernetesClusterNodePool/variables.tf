variable "node-pool-name" {}
variable "kubernetes-cluster-id" {}
variable "cluster-node-count" {}
variable "vm-size" {
    default = "Standard_D2_v2"
}
variable "tags" {
    type = map(any)
    default = {}
}