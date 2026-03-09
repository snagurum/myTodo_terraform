resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_pair_name
  source_dest_check           = var.source_dest_check
  iam_instance_profile        = var.role_name == null ? null : aws_iam_instance_profile.this[0].name
  vpc_security_group_ids      = toset(flatten([[module.ec2_security_group.id], coalesce(var.security_group_ids, []), ]))
  associate_public_ip_address = var.associate_public_ip_address
  user_data_base64 = var.user_data_base64 != null ? var.user_data_base64 : base64encode(templatefile("${path.module}/userdata.tpl", {
  }))

  tags = {
    Name = var.name
  }
}

resource "aws_iam_instance_profile" "this" {
  count = var.role_name == null ? 0 : 1
  name  = "${var.role_name}-${var.name}-instance-profile"
  role  = var.role_name
}

module "ec2_security_group" {
  source        = "../sg"
  vpc_id        = var.vpc_id
  name          = var.name
  ingress_rules = var.ingress_rules
}

