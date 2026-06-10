# Create a vpc 
resource "aws_vpc" "vpc_s3" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "vpc_s3"
  }
}