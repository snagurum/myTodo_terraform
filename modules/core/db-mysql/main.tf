resource "aws_db_instance" "my_mysql_db" {
  allocated_storage      = var.storage
  engine                 = var.db_engine
  engine_version         = var.mysql_engine_version
  instance_class         = var.db_instance_class
  identifier             = var.db_identifier
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = var.skip_final_snapshot
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.db_security_group_ids
  publicly_accessible    = var.publicly_accessible
  deletion_protection    = var.deletion_protection
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-db-subnet-group"
  subnet_ids = var.db_subnet_group_ids
}

