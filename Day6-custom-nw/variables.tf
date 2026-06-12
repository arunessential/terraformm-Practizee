variable "ami_id" {
    description = "The ID of the AMI to use for the instance"
    type        = string
    default     = ""
}

variable "instance_type" {
    description = "EC2 instance type for demo instance"
    type        = string
    default     = ""
}

variable "instance_name" {
    description = "The name of the instance"
    type        = string
    default     = ""
}