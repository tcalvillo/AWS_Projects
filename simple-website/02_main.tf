
# Defines the resources needed for the website

provider "aws" {
  region = "us-east-1"  
}

resource "aws_s3_bucket" "website_bucket" {
    #bucket = var.bucket_name
    bucket = "s3-${var.region}-${var.appstackcode}-${var.shortEnv}-website"
}

resource "aws_s3_bucket_website_configuration" "website_config" {
    bucket = aws_s3_bucket.website_bucket.id

    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "error.html"
    }
  
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
      },
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetBucketLocation",
        Resource = "${aws_s3_bucket.website_bucket.arn}"
      }
    ]
  })
}


resource "aws_s3_bucket_public_access_block" "public_access_block" {
    bucket = aws_s3_bucket.website_bucket.id

    block_public_acls = false
    ignore_public_acls = false
    block_public_policy = false
    restrict_public_buckets = false
}



