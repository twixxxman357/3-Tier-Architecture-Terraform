############################
# ALB Security Group
############################

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "security group for external Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
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
    Name        = "ALB-SG"
    Tier        = "LoadBalancer"
    Project     = "Three-Tier-Architecture"
    Environment = "Dev"
  }
}

############################
# Web Tier Security Group
############################

resource "aws_security_group" "web_sg" {
  name        = "web-tier-sg"
  description = "Security group for Web tier EC2 instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Web-Tier-SG"
    Tier        = "Web"
    Project     = "Three-Tier-Architecture"
    Environment = "Dev"
  }
}

############################
# App Tier Security Group
############################

resource "aws_security_group" "app_sg" {
  name        = "app-tier-sg"
  description = "Security group for App tier EC2 instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow HTTP from backend ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.be_alb_sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "App-Tier-SG"
    Tier        = "Application"
    Project     = "Three-Tier-Architecture"
    Environment = "Dev"
  }
}

############################
# Database Tier Security Group
############################

resource "aws_security_group" "db_sg" {
  name        = "db-tier-sg"
  description = "Security group for Database tier"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow MySQL from App tier"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "DB-Tier-SG"
    Tier        = "Database"
    Project     = "Three-Tier-Architecture"
    Environment = "Dev"
  }
}

resource "aws_security_group" "be_alb_sg" {
  name        = "be-alb-sg"
  description = "Security group for backend ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow HTTP from Web tier"
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

  tags = merge(
    local.common_tags,
    {
      Name = "BE-ALB-SG"
      Tier = "LoadBalancer"
    }
  )
}
