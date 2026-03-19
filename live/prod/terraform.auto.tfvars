aws_profile = "me"
project     = "mytodo"
env         = "prod"
region      = "ap-south-1"

todo_hosted_zone_url = "snagurum.in"
todo_api_url         = "api.snagurum.in"
todo_url             = "snagurum.in"
todo_alt_urls        = ["www.snagurum.in", "snagurum.in"]


todo_ecr_name = "mytodo_ecr"

vpc_cidr             = "10.1.0.0/16"
azs                  = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnets_cidr  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnets_cidr = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]
create_nat_gateway   = true


github_repos_url = ["repo:snagurum/myTodo_fe:*", "repo:snagurum/myTodo_be:*"]

