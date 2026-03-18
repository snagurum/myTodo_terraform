variable "aws_profile" {}

variable "project" {}

variable "env" {}

variable "region" {}

#-------- hosted zone ----------------
variable "todo_hosted_zone_url" {}

#-------- api ----------------
variable "todo_api_url" {}

#-------- spa ----------------
variable "todo_url" {}

variable "todo_alt_urls" {
  type = list(string)
}

#-------- ecr ----------------
variable "todo_ecr_name" {}

#-------- vpc-sg-subnet ----------------
variable "vpc_cidr" {}

variable "azs" {}

variable "public_subnets_cidr" {}

variable "private_subnets_cidr" {}

variable "create_nat_instance" {}

variable "github_repos_url" {}