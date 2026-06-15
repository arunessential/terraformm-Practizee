# create db password
variable "db_password" {
  description = "The password managed by you for the RDS master user"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "The password must be at least 8 characters long."
  }
}