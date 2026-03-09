
output "ids" {
  value = aws_subnet.this[*].id
}

output "nat_gateway_id" {
  value = try(module.nat_gateway.id, null)
}

output "nat_instance_id" {
  value = try(module.nat_instance.id, null)
}