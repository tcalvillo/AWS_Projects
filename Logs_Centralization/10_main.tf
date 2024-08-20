#------------------------------- s3 central bucket ---------------------------------
# Creates the central bucket 
resource "aws_s3_bucket" "ec2logs_central_bucket" {
  bucket = "s3-company-${var.appstackcode}-${var.shortEnv}-ec2logs-central"


  object_lock_enabled = true        ## lock the buckets
}

## set retention days on S3 . 
resource "aws_s3_bucket_lifecycle_configuration" "retention_central_bucket" {
  bucket  = aws_s3_bucket.ec2logs_central_bucket.id
  rule {
      id      = "ec2logs-retention"
      status = "Enabled"

      expiration {
          days = var.logs_s3_retention_central    # 18 months
      }
  }
}

# Compliance mode locks the objects inside central bucket for 18 months (548 days)
resource "aws_s3_bucket_object_lock_configuration" "lock_central_bucket" {
  bucket = aws_s3_bucket.ec2logs_central_bucket.id
  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 548
    }
  }
}

# Defines the central bucket policy
resource "aws_s3_bucket_policy" "central-bucket-policy" {
  bucket = aws_s3_bucket.ec2logs_central_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Principal = "*"
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.ec2logs_central_bucket.arn}/*",
      }
    ]
  })
}






