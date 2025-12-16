resource "aws_db_subnet_group" "db_subnets" {
  subnet_ids = aws_subnet.private_db[*].id

  tags = merge(
    local.common_tags,
    {
      Name = "DB-Subnet-Group"
      Tier = "Database"
    }
  )
}

resource "aws_db_instance" "db" {
  allocated_storage   = 20
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  username            = "admin"
  password            = "password123"
  skip_final_snapshot = true

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "RDS-MySQL-DB"
      Tier = "Database"
    }
  )
}
