

# Availability Zones
locals {
  azs = ["us-east-1a", "us-east-1b"]
}

########################
# Public Web Subnets
########################
resource "aws_subnet" "public_web" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Web-Subnet-AZ-${count.index + 1}"
    Tier = "Web"
  }
}

########################
# Private App Subnets
########################
resource "aws_subnet" "private_app" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 11}.0/24"
  availability_zone = local.azs[count.index]

  tags = {
    Name = "Private-App-Subnet-AZ-${count.index + 1}"
    Tier = "App"
  }
}

########################
# Private DB Subnets
########################
resource "aws_subnet" "private_db" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 21}.0/24"
  availability_zone = local.azs[count.index]

  tags = {
    Name = "Private-DB-Subnet-AZ-${count.index + 1}"
    Tier = "DB"
  }
}
