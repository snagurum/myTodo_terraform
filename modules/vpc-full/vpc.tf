module "vpc" {
  source   = "../core/vpc"
  name     = var.name
  vpc_cidr = var.vpc_cidr
}


module "public_subnet" {
  source                  = "../core/subnet"
  name                    = var.name
  vpc_id                  = module.vpc.vpc_id
  azs                     = var.azs
  subnet_cidrs            = var.public_subnet_cidrs
  igw_id                  = module.vpc.internet_gateway_id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  depends_on              = [module.vpc]
}

module "private_subnet" {
  source                  = "../core/subnet"
  name                    = var.name
  vpc_id                  = module.vpc.vpc_id
  vpc_cidr                = var.vpc_cidr
  azs                     = var.azs
  subnet_cidrs            = var.private_subnet_cidrs
  igw_id                  = module.vpc.internet_gateway_id
  create_nat_gateway      = var.create_nat_gateway
  create_nat_instance     = var.create_nat_instance
  public_subnet_ids       = tolist(module.public_subnet.ids)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  depends_on              = [module.vpc, module.public_subnet]
}