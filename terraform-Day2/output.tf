output "instance_publicIP" {
    description = "Public IP address of the instance"
    value       = aws_instance.demo-instance.public_ip
}

output "instance_id" {
    description = "ID of the instance"
    value       = aws_instance.demo-instance.id
}