# Variables for the instance
variable "ami_id" {
  description = "The AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the instance"
  type        = string
}

variable "instance_name" {
  description = "The name tag for the instance"
  type        = string
}