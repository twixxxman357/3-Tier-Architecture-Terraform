resource "aws_s3_bucket" "architecture_bucket" {
  provider = aws.us_east_2

  bucket = "3-tier-bucket-0357"

  tags = {
    Name        = "3-tier-architecture-bucket"
    Project     = "Three-Tier-Architecture"
    Environment = "Dev"
    Region      = "us-east-2"
  }
}
