
module "eks" {
  source       = "../../modules/core/eks"
  cluster_name = "${var.project}-${var.env}"
  vpc_id       = module.vpc-full.vpc_id
  subnet_ids   = module.vpc-full.private_subnet_ids
}

