output "db-url" {
  value = aws_db_instance.my_mysql_db.address
}

output "db-arn" {
  value = aws_db_instance.my_mysql_db.arn
}
