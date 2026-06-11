# Create a vpc 
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "Terraform-1100AM"
  }
}

# Create a aws subnet
resource "aws_subnet" "name" {
  vpc_id     = aws_vpc.name.id
  cidr_block = "10.0.0.0/26"
  tags = {
    Name = "subnet_s7"
  }
}




