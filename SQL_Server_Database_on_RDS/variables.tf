
variable "regions" {
  description = "List of AWS regions to deploy into"
  type        = list(string)
  default     = ["us-east-1"]
}

variable "key_pair_name" {
  description = "Name of the SSH key pair"
  type        = string
  # NOTE: Use environment variables on your laptop for default values
}

variable "my_public_ip" {
  description = "My public IP for SSH access"
  type        = string
  # NOTE: Use environment variables on your laptop for default values
  # Example: $env:TF_VAR_my_public_ip = "your IP/32 here"
}

variable "root_domain" {
  description = "Root domain for Route 53"
  type        = string
  # NOTE: Use environment variables on your laptop for default values
}

variable "db_username" {
  description = "RDS database username"
  type        = string
  # NOTE: Use environment variables on your laptop for default values
}


variable "db_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
}



