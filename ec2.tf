############################
# Web Tier – Public Subnets
############################

resource "aws_instance" "web_az1" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_web[0].id

  tags = {
    Name = "Web-Instance-AZ-1"
    Tier = "Web"
    AZ   = "us-east-1a"
  }
}

resource "aws_instance" "web_az2" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_web[1].id

  tags = {
    Name = "Web-Instance-AZ-2"
    Tier = "Web"
    AZ   = "us-east-1b"
  }
}

############################
# App Tier – Private Subnets
############################

resource "aws_instance" "app_az1" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_app[0].id

  tags = {
    Name = "App-Instance-AZ-1"
    Tier = "App"
    AZ   = "us-east-1a"
  }
}

resource "aws_instance" "app_az2" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_app[1].id

  tags = {
    Name = "App-Instance-AZ-2"
    Tier = "App"
    AZ   = "us-east-1b"
  }
}
