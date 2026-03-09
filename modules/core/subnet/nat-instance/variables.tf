variable "name" {
  description = "name"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
  default     = null
}

variable "private_subnet_ids" {
  description = "private subnets"
  type        = map(string)
}


variable "public_subnet_ids" {
  description = "private subnets"
  type        = list(string)
}


variable "instance_type" {
  description = "ec2 nat instance type"
  type        = string
}


variable "key_pair_name" {
  description = "ec2 nat instance type"
  type        = string
}