# variable "project" {
#   description = "Project name"
#   type        = string
# }

# variable "env" {
#   description = "environment"
#   type        = string
# }

variable "name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
