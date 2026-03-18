
variable "eks_cluster_name" {
  type = string
}

variable "parameter_store_name" {
  type = string
}

variable "sa_prefix" {
  type = string
}

variable "namespace" {
  type    = string
  default = "default"
}
