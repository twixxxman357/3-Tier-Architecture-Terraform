variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet1_cidr" {
  type = string
}

variable "public_subnet2_cidr" {
  type = string
}

variable "private_app_subnet1_cidr" {
  type = string
}

variable "private_app_subnet2_cidr" {
  type = string
}

variable "private_db_subnet1_cidr" {
  type = string
}

variable "private_db_subnet2_cidr" {
  type = string
}

variable "my_security_group_name" {
  type = string
}

variable "my_security_group_description" {
  type = string
}

variable "elb_security_group_name" {
  type = string
}

variable "elb_security_group_description" {
  type = string
}

variable "web_sg_name" {
  type = string
}

variable "web_sg_description" {
  type = string
}

variable "internal_elb_sg_name" {
  type = string
}

variable "internal_elb_sg_description" {
  type = string
}

variable "private_sg_name" {
  type = string
}

variable "private_sg_description" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_ami" {
  type = string
}

variable "web_tier_elb_name" {
  type = string
}

variable "web_tier_elb_type" {
  type = string
}

variable "internal_elb_name" {
  type = string
}

variable "internal_elb_type" {
  type = string
}

variable "your_ip_address" {
  type = string
}

##############################
# DATABASE VARIABLES (Corrected)
##############################

variable "database_engine" {
  type    = string
  default = "aurora-postgresql"
}

variable "database_engine_version" {
  type    = string
  default = "15.6" # FIXED — valid Aurora PostgreSQL version
}

variable "database_vpc_security_group_ids" {
  type    = list(string)
  default = ["private-sg"]
}

variable "database_db_subnet_group_name" {
  type    = string
  default = "database-subnet-group"
}

variable "database_availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "database_read_replica_availability_zone" {
  type    = string
  default = "us-east-1c"
}

variable "database_instance_class" {
  type    = string
  default = "db.r5.large"
}

variable "database_identifier" {
  type    = string
  default = "aurora-cluster"
}

variable "database_read_replica_identifier" {
  type    = string
  default = "aurora-read-replica-az2"
}

