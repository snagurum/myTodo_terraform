locals {
  create_nat_gateway      = var.create_nat_gateway ? true : false
  create_nat_instance     = !local.create_nat_gateway && var.create_nat_instance ? true : false
  is_public_subnet        = !local.create_nat_gateway && !local.create_nat_instance ? true : false
  name                    = local.is_public_subnet ? "${var.name}-public" : "${var.name}-private"
  map_public_ip_on_launch = var.map_public_ip_on_launch && local.is_public_subnet ? true : false
}

# -------------------------------
# Subnets
# -------------------------------
resource "aws_subnet" "this" {
  count                   = length(var.subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = local.map_public_ip_on_launch

  tags = merge({
    Name = "${local.name}-${count.index + 1}"
  },local.is_public_subnet?{
    "kubernetes.io/role/elb" = "1"
  } : {
      "kubernetes.io/role/internal-elb" = "1"
  })
}

resource "aws_route_table" "rt" {
  count  = local.is_public_subnet == true ? 1 : 0
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "${local.name}-rt"
  }
}

resource "aws_route_table_association" "public_subnet" {
  count          = local.is_public_subnet ? length(var.subnet_cidrs) : 0
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.rt[0].id
}

module "nat_gateway" {
  count              = local.create_nat_gateway ? 1 : 0
  source             = "./nat-gateway"
  name               = local.name
  vpc_id             = var.vpc_id
  private_subnet_ids = tolist(aws_subnet.this[*].id)
  public_subnet_ids  = var.public_subnet_ids
}

module "nat_instance" {
  count    = local.create_nat_instance ? 1 : 0
  source   = "./nat-instance"
  name     = local.name
  vpc_id   = var.vpc_id
  vpc_cidr = var.vpc_cidr
  # private_subnet_ids = tolist(aws_subnet.this[*].id)
  private_subnet_ids = zipmap(
    [for i in range(length(tolist(aws_subnet.this[*].id))) : "private_${i + 1}"],
    tolist(aws_subnet.this[*].id)
  )
  public_subnet_ids = var.public_subnet_ids
  key_pair_name     = var.ni_key-pair_name
  instance_type     = "t3.nano"
}