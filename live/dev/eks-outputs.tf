# output "eks" {
#   value = module.eks
# }

output "todo-api-acm-cert-arn" {
  value = try(module.todo-api-acm-cert.acm_cert_arn, null)
}
