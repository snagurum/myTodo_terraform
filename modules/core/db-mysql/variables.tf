
variable "db_identifier" {
  type = string
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

variable "skip_final_snapshot" {
  type    = bool
  default = false
}

variable "db_subnet_group_ids" {
  type = list(string)
}

variable "db_security_group_ids" {
  type = list(string)
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "storage" {
  type    = number
  default = 20
}

