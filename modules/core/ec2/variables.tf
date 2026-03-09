
# variable "project" {
#   description = "Project name"
#   type        = string
# }

variable "name" {
  type = string
}

# variable "env" {
#   description = "environment"
#   type        = string
# }

variable "vpc_id" {

}

variable "ami_id" {
  description = "ami image id"
}

variable "instance_type" {
  description = "instance type"
}


variable "subnet_id" {
  description = "subnet ids"
}

variable "key_pair_name" {

}

variable "role-name" {
  default = ""
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}


variable "user_data_base64" {
  default = null
}

variable "associate_public_ip_address" {
  default = false
}

variable "ingress_rules" {
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
    description = optional(string)
  }))
  default = [{
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }]
}

variable "source_dest_check" {
  description = "source destination check used for nat instance setup, false for nat-instances"
  default     = true
}

variable "role_name" {
  description = "role name to attach as instance profile"
  default     = null
}
