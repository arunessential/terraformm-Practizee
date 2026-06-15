# Create a vpc
resource "aws_vpc" "vpc-x2" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC-x2"
  }

}   

# Create subnet
resource "aws_subnet" "subnet-x2" {
    vpc_id            = aws_vpc.vpc-x2.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
}

# Create Security group
resource "aws_security_group" "sg-x2" {
    name        = "vpc-x2-sg"
    description = "Security group for EC2 instance"
    vpc_id      = aws_vpc.vpc-x2.id

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




# create an ec2 instance in vpc "vpc-x2"
resource "aws_instance" "ec2-zx2" {
    vpc_security_group_ids = [aws_security_group.sg-x2.id]
    subnet_id               = aws_subnet.subnet-x2.id
    instance_type           = "t3.micro"
    ami                     = "ami-00e801948462f718a"
}

# Create a S3 bucket
resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket-x6"
  depends_on = [ aws_instance.ec2-zx2 ]
}