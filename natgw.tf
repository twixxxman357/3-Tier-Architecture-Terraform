resource "aws_eip" "nat_eip" {
  count  = 2
  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "NAT-EIP-AZ-${count.index + 1}"
      Tier = "Network"
    }
  )
}

resource "aws_nat_gateway" "nat" {
  count         = 2
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_web[count.index].id

  tags = merge(
    local.common_tags,
    {
      Name = "NAT-Gateway-AZ-${count.index + 1}"
      Tier = "Network"
    }
  )
}
