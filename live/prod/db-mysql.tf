
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "aws_ssm_parameter" "db_pwd" {
  name        = "/mytodo/${var.env}/db_password"
  description = "Production environment database password"
  type        = "SecureString"
  value       = random_password.db_password.result
  lifecycle {
    ignore_changes = [value]
  }
}

module "mysql-db" {
  source                = "../../modules/core/db-mysql"
  db_identifier         = "${var.env}-${var.project}"
  db_name               = var.project
  db_subnet_group_ids   = module.vpc-full.private_subnet_ids
  db_username           = "root"
  db_password           = aws_ssm_parameter.db_pwd.value_wo
  db_security_group_ids = [module.db-sg.id]
  skip_final_snapshot   = true
  deletion_protection   = false
}

module "db-sg" {
  source = "../../modules/core/sg"
  vpc_id = module.vpc-full.vpc_id
  ingress_rules = [{
    port        = 3306
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr
    description = "DB access"
  }]
}
