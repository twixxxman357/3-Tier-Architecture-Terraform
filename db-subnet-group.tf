resource "aws_db_subnet_group" "db_subnets" {
  name        = "db-subnet-group"
  description = "Subnet group for database tier"
  subnet_ids  = aws_subnet.private_db[*].id

  tags = {
    Name = "DB-Subnet-Group"
    Tier = "DB"
  }
}
