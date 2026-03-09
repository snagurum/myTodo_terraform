output "vpc_id" {
  value = module.vpc.vpc_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "private_subnet_ids" {
  value = module.private_subnet.ids
}

output "public_subnet_ids" {
  value = module.public_subnet.ids
}

output "nat_gateway_id" {
  value = try(module.private_subnet.nat_gateway_id, null)
}

output "nat_instance_id" {
  value = try(module.private_subnet.nat_instance_id, null)
}