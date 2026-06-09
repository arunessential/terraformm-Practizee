# create aws instance using terraform
resource "aws_instance" "demo-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
    tags = {
        Name = var.instance_name
    }
}
