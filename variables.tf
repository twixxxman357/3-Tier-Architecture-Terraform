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