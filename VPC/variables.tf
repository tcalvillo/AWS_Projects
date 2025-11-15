variable "regions" {
  description = "List of AWS regions to deploy into"
  type        = list(string)
  default     = ["us-east-1", "us-west-1"]
}
