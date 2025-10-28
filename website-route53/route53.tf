# Route 53 zone
resource "aws_route53_zone" "primary" {
  name = var.root_domain
}

# Root domain alias (01899.shop)
resource "aws_route53_record" "cloudfront_alias_root" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.root_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.my_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.my_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# www subdomain alias (www.01899.shop)
resource "aws_route53_record" "cloudfront_alias_www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.root_domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.my_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.my_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
