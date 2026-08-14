
variable "db_identifier" {
  type = string
}

variable "db_storage" {
  type    = number
  default = 20
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "mysql_engine_version" {
  type    = string
  default = "8.0"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_skip_final_snapshot" {
  type    = bool
  default = false
}

variable "db_deletion_protection" {
  type    = bool
  default = true
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_subnet_group_ids" {
  type = list(string)
}

variable "db_security_group_ids" {
  type = list(string)
}

variable "db_publicly_accessible" {
  type    = bool
  default = false
}

variable "db_backup_retention_period" {
  type    = number
  default = 7
}

variable "db_maintenance_window" {
  type    = string
  default = "Sun:04:30-Sun:05:30"
}

variable "db_max_storage" {
  type    = number
  default = 1000
}

variable "db_backup_window" {
  type    = string
  default = "03:00-04:00"
}

variable "db_storage_encrypted" {
  type    = bool
  default = true
}