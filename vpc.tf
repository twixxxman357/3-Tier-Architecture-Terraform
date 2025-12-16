data "aws_vpc" "my_vpc" {
  id = aws_vpc.my_vpc.id
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

