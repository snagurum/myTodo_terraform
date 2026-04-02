
module "eks" {
  source                  = "../../modules/core/eks"
  cluster_name            = "${var.project}-${var.env}"
  vpc_id                  = module.vpc-full.vpc_id
  subnet_ids              = module.vpc-full.private_subnet_ids
  node_group_desired_size = 3
  node_group_min_size     = 2
  node_group_max_size     = 4
  cluster_version = var.cluster_version
}

