# CloudFront Distribution Domain Name
output "cloudfront_domain_name" {
  description = "The domain name assigned to the CloudFront distribution"
  value       = aws_cloudfront_distribution.my_distribution.domain_name
}

# ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the ACM SSL/TLS certificate used for HTTPS"
  value       = aws_acm_certificate.cert.arn
}

# Route53 Zone ID
output "route53_zone_id" {
  description = "The ID of the Route53 hosted zone"
  value       = aws_route53_zone.primary.zone_id
}

# S3 Bucket Name
output "s3_bucket_name" {
  description = "The name of the S3 bucket used for the website"
  value       = aws_s3_bucket.bucket.bucket
}

# Website URLs
output "website_urls" {
  description = "Access URLs for the website (CloudFront and domain)"
  value = {
    cloudfront = "https://${aws_cloudfront_distribution.my_distribution.domain_name}"
    domain     = "https://www.01899.shop"
    root_domain = "https://01899.shop"
  }
}
