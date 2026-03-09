
# -------------------------------
# Elastic IP for NAT Gateway
# -------------------------------
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.name}-nat-eip"
  }
}



# -------------------------------
# NAT Gateway
# -------------------------------
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = tolist(var.public_subnet_ids)[0]
  tags = {
    Name = "${var.name}-natgw"
  }

}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "this" {
  count          = length(var.private_subnet_ids)
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = aws_route_table.this.id
}