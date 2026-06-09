# Store output of the instances
output "instance_id" {
  value = aws_instance.demo-instance.id
}

output "instance_public_ip" {
  value = aws_instance.demo-instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.demo-instance.private_ip
}

output "instance_public_dns" {
  value = aws_instance.demo-instance.public_dns
}

output "instance_private_dns" {
  value = aws_instance.demo-instance.private_dns
}

output "instance_ami" {
  value = aws_instance.demo-instance.ami
}

output "instance_instance_type" {
  value = aws_instance.demo-instance.instance_type
}

output "instance_tags" {
  value = aws_instance.demo-instance.tags
}

output "instance_key_name" {
  value = aws_instance.demo-instance.key_name
}

