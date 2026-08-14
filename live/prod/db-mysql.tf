
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
  source                     = "../../modules/core/db-mysql"
  db_identifier              = "${var.env}-${var.project}"
  db_name                    = var.project
  db_storage                 = var.db_storage
  db_subnet_group_ids        = module.vpc-full.private_subnet_ids
  db_username                = "root"
  db_password                = aws_ssm_parameter.db_pwd.value
  db_security_group_ids      = [module.db-sg.id]
  db_skip_final_snapshot     = var.db_skip_final_snapshot
  db_deletion_protection     = var.db_deletion_protection
  db_multi_az                = var.db_multi_az
  db_backup_retention_period = var.db_backup_retention_period
  db_backup_window           = var.db_backup_window
  db_maintenance_window      = var.db_maintenance_window
  db_storage_encrypted       = true
}

module "db-sg" {
  source = "../../modules/core/sg"
  vpc_id = module.vpc-full.vpc_id
  name   = "${var.env}-${var.project}-db"
  ingress_rules = [{
    port        = 3306
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr
    description = "DB access"
  }]
}
