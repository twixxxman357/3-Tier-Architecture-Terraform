
data "aws_vpc" "my_vpc" {
  id = aws_vpc.my_vpc.id
}

resource "aws_db_instance" "aurora_cluster" {
  identifier           = var.database_identifier
  instance_class       = var.database_instance_class
  engine               = var.database_engine
  engine_version       = var.database_engine_version
  allocated_storage    = 20
  username             = "aurorauser"
  password             = "aurorapassword"
  vpc_security_group_ids = var.database_vpc_security_group_ids
  db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
  availability_zone   = var.database_availability_zone
}

resource "aws_db_instance" "aurora_read_replica_az2" {
  identifier           = var.database_read_replica_identifier
  instance_class       = var.database_instance_class
  engine               = var.database_engine
  engine_version       = var.database_engine_version
  allocated_storage    = 20
  username             = "aurorauser"
  password             = "aurorapassword"
  vpc_security_group_ids = var.database_vpc_security_group_ids
  db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
  availability_zone   = var.database_read_replica_availability_zone
  replicate_source_db = aws_db_instance.aurora_cluster.arn
}

resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "database-subnet-group"
  subnet_ids = [aws_subnet.private_db_subnet1.id, aws_subnet.private_db_subnet2.id]

  tags = {
    Name = "database-subnet-group"
  }
}

resource "aws_subnet" "private_db_subnet1" {
  vpc_id            = data.aws_vpc.my_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "database-tier-private-subnet-1"
    Environment = "dev"
    Project     = "my-project"
    AZ          = "us-east-1a"
  }
}
