# Creation of VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Dev_VPC"
    }
}


# Creation of Subnet
resource "aws_subnet" "custom_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
    tags = {
        Name = "Dev_Subnet"
    }
}

# Creation of Private Subnet
resource "aws_subnet" "custom_private_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
    tags = {
        Name = "Dev_Private_Subnet"
    }  
}

# Creation of Internet gateway
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id
    tags = {
        Name = "Dev_IGW"
    }
}

# Creation of Route table to internet gateway
resource "aws_route_table" "custom_route_table" {
  vpc_id = aws_vpc.custom_vpc.id
    tags = {
        Name = "Dev_Route_Table"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.custom_igw.id
    }
}

# Association of route table with public subnet
resource "aws_route_table_association" "custom_route_table_association" {
  subnet_id      = aws_subnet.custom_subnet.id
  route_table_id = aws_route_table.custom_route_table.id
}      

# Creation of Security group
resource "aws_security_group" "custom_sg" {
  name        = "Dev_SG"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creation of EC2 instance in public subnet
resource "aws_instance" "custom_instance" {
  ami           = var.ami_id# Amazon Linux 2 AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.custom_subnet.id
  vpc_security_group_ids = [aws_security_group.custom_sg.id]

  tags = {
    Name = var.instance_name
  }
}

