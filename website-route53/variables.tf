# Domain name (root domain)
variable "root_domain" {
  description = "The root domain name for the website (no www)"
  type        = string
  default     = "01899.shop"
}

# Subdomain for the main website
variable "www_domain" {
  description = "The www domain name"
  type        = string
  default     = "www.01899.shop"
}

# S3 bucket name
variable "bucket_name" {
  description = "The name of the S3 bucket for hosting the website"
  type        = string
  default     = "tiz-travel-website-01899"
}

# TTL for DNS records
variable "dns_ttl" {
  description = "TTL (time to live) for Route53 DNS records"
  type        = number
  default     = 300
}
