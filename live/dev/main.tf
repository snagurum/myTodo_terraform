
module "spa" {
  source               = "../../modules/spa"
  bucket_name          = var.todo_url
  domain_name_cert_arn = ""
}

