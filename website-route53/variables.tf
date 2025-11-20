# Domain name (root domain)
variable "root_domain" {
  description = "The root domain name for the website (no www)"
  type        = string
  # NOTE: Use environment variables on your laptop for default value
}

# Subdomain for the main website
variable "www_domain" {
  description = "The www domain name"
  type        = string
  # NOTE: Use environment variables on your laptop for default value
}

# S3 bucket name
variable "bucket_name" {
  description = "The name of the S3 bucket for hosting the website"
  type        = string
  # NOTE: Use environment variables on your laptop for default value
}

# TTL for DNS records
variable "dns_ttl" {
  description = "TTL (time to live) for Route53 DNS records"
  type        = number
  default     = 300
}
