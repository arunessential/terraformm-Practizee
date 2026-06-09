# Create aws vpc
resource "aws_vpc" "nuno-mendes" {
  cidr_block = "10.0.0.0/24"
}

# Create aws subnet
resource "aws_subnet" "nuno-mendes-subnet" {
  vpc_id            = aws_vpc.nuno-mendes.id
  cidr_block        = "10.0.0.0/26"
}