variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "vpc_id" {}

variable "subnet_ids" {
  type = set(string)
}

variable "node_group_name" {
  type    = string
  default = "default"
}

variable "node_group_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}


