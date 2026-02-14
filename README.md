Welcome to my Personal Project 

Everything that is done in this project is explained so enjoy

# Terraform Configuration for Web Application

This Terraform configuration sets up a web application infrastructure on AWS. The configuration includes:

* A VPC with two public subnets and two private subnets
* Two web tier instances in the public subnets
* Two app tier instances in the private subnets
* An external load balancer (Web Tier Load Balancer) that distributes traffic to the web tier instances
* An internal load balancer (Internal Load Balancer) that distributes traffic to the app tier instances
* Security groups to control access to the instances and load balancers
* Route tables to route traffic between the subnets and load balancers

## Variables

* `aws_region`: The AWS region to use for the configuration
* `vpc_cidr`: The CIDR block for the VPC
* `public_subnet1_cidr`: The CIDR block for the first public subnet
* `public_subnet2_cidr`: The CIDR block for the second public subnet
* `private_app_subnet1_cidr`: The CIDR block for the first private app subnet
* `private_app_subnet2_cidr`: The CIDR block for the second private app subnet
* `instance_type`: The instance type to use for the web tier and app tier instances
* `instance_ami`: The AMI to use for the web tier and app tier instances
* `web_tier_elb_name`: The name of the Web Tier Load Balancer
* `internal_elb_name`: The name of the Internal Load Balancer

## Security

* The security groups are configured to allow traffic from the load balancers to the instances
* The security groups are also configured to allow traffic from the instances to the load balancers
* The route tables are configured to route traffic between the subnets and load balancers



<img width="1214" height="548" alt="image" src="https://github.com/user-attachments/assets/dab96295-6126-4f5b-ad42-6cc7020d066f" />
