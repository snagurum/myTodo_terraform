module "vpc-full" {
  source                  = "../../modules/vpc-full"
  name                    = "${var.project}-${var.env}"
  azs                     = var.azs
  public_subnet_cidrs     = var.public_subnets_cidr
  private_subnet_cidrs    = var.private_subnets_cidr
  create_nat_instance     = var.create_nat_instance
  map_public_ip_on_launch = true
  vpc_cidr                = var.vpc_cidr
}



