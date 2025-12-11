
#security groups for public web tier

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for web tier instances"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_security_group.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["80.44.95.145/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "web-sg"
    Environment = "dev"
    Project     = "my-project"
  }
}

#security group for private instances internal ELB

resource "aws_security_group" "internal_elb_sg" {
  name        = "internal-elb-sg"
  description = "Security group for internal load balancer"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "internal-elb-sg"
    Environment = "dev"
    Project     = "my-project"
  }
}

// private_sg.tf

data "aws_security_group" "internal_elb_sg" {
  name = aws_security_group.internal_elb_sg.name
}

resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private instances"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [data.aws_security_group.internal_elb_sg.id]
  }

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["89.243.9.81/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "private-sg"
    Environment = "dev"
    Project     = "my-project"
  }
}

