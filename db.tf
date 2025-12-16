
##############################
# DB SUBNET GROUP
##############################
resource "aws_db_subnet_group" "database_subnet_group" {
  name = "database-subnet-group"
  subnet_ids = [
    aws_subnet.private_db_subnet1.id,
    aws_subnet.private_db_subnet2.id
  ]

  tags = {
    Name = "database-subnet-group"
  }
}

##############################
# PRIVATE SUBNET (REMOVE DUPLICATES)
##############################
resource "aws_subnet" "private_db_subnet2" {
  vpc_id                  = data.aws_vpc.my_vpc.id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = false

  tags = {
    Name        = "database-tier-private-subnet-2"
    Environment = "dev"
    Project     = "my-project"
    AZ          = "us-east-1c"
  }
}

##############################
# AURORA CLUSTER (Cluster-level settings only)
##############################
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = var.database_identifier

  # FIXED: These are the correct attribute names
  master_username = "aurorauser"
  master_password = "aurorapassword"

  engine         = var.database_engine
  engine_version = var.database_engine_version

  # DO NOT set instance_class on the cluster
  # DO NOT set allocated_storage for Aurora (it auto-scales)

  vpc_security_group_ids = [aws_security_group.private_sg.id]

  db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name

  availability_zones  = [var.database_availability_zone]
  skip_final_snapshot = true
}

##############################
# AURORA WRITER INSTANCE
##############################
resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  identifier         = "${var.database_identifier}-writer"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.database_instance_class

  engine         = var.database_engine
  engine_version = var.database_engine_version
}

##############################
# AURORA READER REPLICA (AZ2)
##############################
resource "aws_rds_cluster_instance" "aurora_read_replica_az2" {
  identifier         = "${var.database_identifier}-reader-az2"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.database_instance_class

  engine         = var.database_engine
  engine_version = var.database_engine_version

  availability_zone = var.database_read_replica_availability_zone
}

resource "aws_db_instance" "db" {
  identifier        = "app-db"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  username = "admin"
  password = "password123"
}
