#HOPE IT WORKS


provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "my-vpc"
    Environment = "dev"
    Project     = "my-project"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "web-tier-public-subnet-1"
    Environment = "dev"
    Project     = "my-project"
    AZ          = "us-east-1a"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name        = "web-tier-public-subnet-2"
    Environment = "dev"
    Project     = "my-project"
    AZ          = "us-east-1c"
  }
}

resource "aws_subnet" "private_app_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "app-tier-private-subnet-1"
    Environment = "dev"
    Project     = "my-project"
    AZ          = "us-east-1a"
  }
}

resource "aws_subnet" "private_app_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = false

  tags = {
    Name        = "app-tier-private-subnet-2"
    Environment = "dev"
    Project     = "my-project"
    AZ          = "us-east-1c"
  }
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "my-security-group"
    Environment = "dev"
    Project     = "my-project"
  }
}

resource "aws_subnet" "private_db_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = false

  tags = {
    Name        = "database-tier-private-subnet-2"
    Environment = "dev"
    Project     = "my-project"
    AZ          = "us-east-1c"
  }
}



