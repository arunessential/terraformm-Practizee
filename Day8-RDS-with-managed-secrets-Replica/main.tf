# create aws vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "VPC-for-RDS"
    }
}

# Create subnet
resource "aws_subnet" "my_subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
    tags = {
        Name = "Subnet1-for-RDS"
    }
}

# Create Subnet 2
resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
    tags = {
        Name = "Subnet2-for-RDS"
    }   
}


# Create subnet group
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.my_subnet1.id, aws_subnet.my_subnet2.id]
    tags = {
        Name = "DB-Subnet-Group-for-RDS"
    }
}

# Create security group
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.my_vpc.id
    tags = {
        Name = "Security-Group-for-RDS"
    }   

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

# create aws rds instance
resource "aws_db_instance" "mydb" {
  identifier             = "mydb-instance-xyz"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = var.db_password
  maintenance_window     = "Mon:00:00-Mon:03:00"
  backup_window          = "03:00-06:00"
  skip_final_snapshot    = true
  backup_retention_period = 1
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
}


# Create Read Replica
resource "aws_db_instance" "mydb_replica" {
  count                  = 1 
  identifier             = "replica-instance-1"
  allocated_storage      = 20
  storage_type           = "gp2"
  instance_class         = "db.t3.micro"
  maintenance_window     = "Mon:00:00-Mon:03:00"
  backup_window          = "03:00-06:00"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  replicate_source_db    = aws_db_instance.mydb.arn
  
}