
variable "name" {
  description = "name"
  type        = string
}


variable "is_public" {
  description = "is public subnet"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "map_public_ip_on_launch"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "vpc id"
}

variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
  default     = null
}

variable "igw_id" {
  description = "internet gateway id"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "Subnet CIDRs"
  type        = list(string)
}

variable "create_nat_gateway" {
  type    = bool
  default = false
}

variable "create_nat_instance" {
  type    = bool
  default = false
}

variable "public_subnet_ids" {
  type    = list(string)
  default = null
}