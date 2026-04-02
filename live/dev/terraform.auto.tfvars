aws_profile = "me"
project     = "mytodo-poc"
env         = "dev"
region      = "ap-south-1"

todo_hosted_zone_url = "snagurum.in"
todo_api_url         = "api.dev.snagurum.in"
todo_url             = "dev.snagurum.in"
todo_alt_urls        = ["www.dev.snagurum.in", "dev.snagurum.in"]


todo_ecr_name = "mytodo_dev_ecr"

vpc_cidr             = "10.0.0.0/16"
azs                  = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.11.0/24", "10.0.12.0/24"]
create_nat_instance  = true


github_repos_url = ["repo:snagurum/myTodo_fe:*", "repo:snagurum/myTodo_be:*"]

cluster_version="1.30"
