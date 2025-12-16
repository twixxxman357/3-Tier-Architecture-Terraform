locals {
  azs = ["us-east-2a", "us-east-2b"]

  common_tags = {
    Project     = "Three-Tier-Architecture"
    Environment = "Dev"
    Region      = "us-east-2"
    Owner       = "Terraform"
  }
}