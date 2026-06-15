

data "aws_subnet" "my_subnet1" {
  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"]
  }
}

data "aws_security_group" "my_security_group" {
  filter {
    name   = "group-name"
    values = ["vpc-x2-sg"]
  }
}



resource "aws_instance" "name" {
    instance_type           = "t3.micro"
    ami                     = "ami-00e801948462f718a"
    
    subnet_id = data.aws_subnet.my_subnet1.id #use the id of the fetched subnet
    vpc_security_group_ids = [data.aws_security_group.my_security_group.id]
    
    tags = {
        Name = "my-ec2-instance"
    }
}

