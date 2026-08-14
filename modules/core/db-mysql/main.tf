module "db-kms" {
  count       = var.db_storage_encrypted ? 1 : 0
  source      = "../kms"
  name        = "${var.db_name}-db-kms-key"
  alias_name  = "${var.db_name}-db-kms-key"
  description = "KMS key for encrypting database"
}

resource "aws_db_instance" "my_mysql_db" {
  allocated_storage         = var.db_storage
  engine                    = var.db_engine
  engine_version            = var.mysql_engine_version
  instance_class            = var.db_instance_class
  identifier                = var.db_identifier
  db_name                   = var.db_name
  username                  = var.db_username
  password                  = var.db_password
  skip_final_snapshot       = var.db_skip_final_snapshot
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids    = var.db_security_group_ids
  publicly_accessible       = var.db_publicly_accessible
  deletion_protection       = var.db_deletion_protection
  multi_az                  = var.db_multi_az
  backup_retention_period   = var.db_backup_retention_period
  backup_window             = var.db_backup_window
  maintenance_window        = var.db_maintenance_window
  final_snapshot_identifier = "${var.db_identifier}-final-snapshot"
  max_allocated_storage     = var.db_max_storage
  storage_encrypted         = var.db_storage_encrypted
  kms_key_id                = var.db_storage_encrypted ? module.db-kms[0].key_arn : null
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-db-subnet-group"
  subnet_ids = var.db_subnet_group_ids
}

