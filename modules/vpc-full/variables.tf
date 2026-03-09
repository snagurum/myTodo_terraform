

variable "name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" { default = ["us-east-1a", "us-east-1b"] }

variable "public_subnet_cidrs" { default = ["10.0.1.0/24", "10.0.2.0/24"] }

variable "private_subnet_cidrs" { default = ["10.0.3.0/24", "10.0.4.0/24"] }

variable "create_nat_instance" { default = false }
variable "create_nat_gateway" { default = false }


variable "map_public_ip_on_launch" {
  description = "map_public_ip_on_launch"
  type        = bool
  default     = false
}