
module "eks-addons" {
  source                     = "../../modules/eks-addons"
  eks_cluster_name           = "${var.project}-${var.env}"
  aws_lb_controller_role_arn = module.eks.aws_lb_controller_role_arn
  eks_cluster_ca_data        = module.eks.cluster_certificate_authority_data
  eks_cluster_endpoint       = module.eks.cluster_endpoint
  # certificate_arn            = module.todo-api-acm-cert.acm_cert_arn
  certificate_arn            = null
  depends_on                 = [module.eks]
}


# module "todo-api-acm-cert" {
#   source           = "../../modules/core/acm"
#   domain_name      = var.todo_api_url
#   profile_name     = var.aws_profile
#   use_hosted_zone  = true
#   hosted_zone_name = var.todo_hosted_zone_url
# }

module "eks-secrets-provider" {
  source               = "../../modules/eks-secrets-provider"
  eks_cluster_name     = "${var.project}-${var.env}"
  namespace            = "${var.env}-${var.project}"
  parameter_store_name = "${var.project}/${var.env}"
  depends_on           = [module.eks, module.eks-addons]
  sa_prefix            = "mytodo-prod"
}
