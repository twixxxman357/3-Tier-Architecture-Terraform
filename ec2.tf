resource "aws_instance" "web" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_web[count.index].id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "Web-EC2-AZ-${count.index + 1}"
      Tier = "Web"
    }
  )
}

resource "aws_instance" "app" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_app[count.index].id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "App-EC2-AZ-${count.index + 1}"
      Tier = "Application"
    }
  )
}
