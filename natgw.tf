
resource "aws_nat_gateway" "nat_gateway_1a" {
  allocation_id = aws_eip.nat_eip_1a.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name        = "nat-gateway-1a"
    Environment = "dev"
    Project     = "my-project"
  }
}

resource "aws_eip" "nat_eip_1a" {
  tags = {
    Name        = "nat-eip-1a"
    Environment = "dev"
    Project     = "my-project"
  }
}


resource "aws_nat_gateway" "nat_gateway_1c" {
  allocation_id = aws_eip.nat_eip_1c.id
  subnet_id     = aws_subnet.public_subnet2.id

  tags = {
    Name        = "nat-gateway-1c"
    Environment = "dev"
    Project     = "my-project"
  }
}

resource "aws_eip" "nat_eip_1c" {
  tags = {
    Name        = "nat-eip-1c"
    Environment = "dev"
    Project     = "my-project"
  }
}