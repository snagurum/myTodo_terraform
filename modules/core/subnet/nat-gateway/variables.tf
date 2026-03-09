variable "name" {
  description = "name"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "private_subnet_ids" {
  description = "private subnets"
  type        = list(string)
}


variable "public_subnet_ids" {
  description = "public subnets"
  type        = list(string)
}