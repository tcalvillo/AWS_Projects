resource "aws_s3_bucket" "s3_central_cloud_trail" {
  #count = local.is_gov_resolved ? 1 : 0
  count = var.is_gov ? 1 : 0
  bucket = "s3-company-${var.appstackcode}-${var.shortEnv}-${local.shortRegion}-cloud-trail-central-${count.index}"
  object_lock_enabled = true        ## lock the buckets
}

## set retention days on S3 . 
resource "aws_s3_bucket_lifecycle_configuration" "retention_cloud_trail_central_bucket" {
  count = var.is_gov ? 1 : 0
  bucket  = aws_s3_bucket.s3_central_cloud_trail[count.index].id
  rule {
      id      = "access-logging-retention"
      status = "Enabled"

      expiration {
          days = var.logs_s3_retention_central    # 18 months
      }
  }
}

# Compliance mode locks the objects inside cloud trail central bucket for 18 months (548 days)
resource "aws_s3_bucket_object_lock_configuration" "lock_cloud_trail_central_bucket" {
  count = var.is_gov ? 1 : 0
  bucket = aws_s3_bucket.s3_central_cloud_trail[count.index].id
  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 548
    }
  }
}

# Defines the central bucket cloud trail bucket policy
resource "aws_s3_bucket_policy" "central-bucket-cloud-trail-policy" {
  count = var.is_gov ? 1 : 0
  bucket = aws_s3_bucket.s3_central_cloud_trail[count.index].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Principal = "*"
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.s3_central_cloud_trail[count.index].arn}/*",
      }
    ]
  })
}