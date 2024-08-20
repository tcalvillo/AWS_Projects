#----------------------------- S3 bucket storage logs --------------------------------------
resource "aws_s3_bucket" "ec2logs_bucket" {
  bucket = "s3-company-${var.appstackcode}-${var.shortEnv}-${local.shortRegion}-ec2logs"


  object_lock_enabled = true
}
# Ex. s3-<company>-<appstackcode>-d-ew1-ec2logs 

# compliance mode blocks object for being deleted during retention days
resource "aws_s3_bucket_object_lock_configuration" "lock_regional_bucket" {
  bucket = aws_s3_bucket.ec2logs_bucket.id
  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 7
    }
  }
}

## set retention days on S3 
resource "aws_s3_bucket_lifecycle_configuration" "retention_bucket_ec2logs" {
  bucket = aws_s3_bucket.ec2logs_bucket.id
  rule {
    id     = "ec2logs-retention"
    status = "Enabled"

    expiration {
      days = var.logs_s3_retention # retention =  7 days
    }
  }
}

## set the versionin enabled for replication
resource "aws_s3_bucket_versioning" "versioning_config_ec2logs" {
  bucket = aws_s3_bucket.ec2logs_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

## set the bucket policy for regional buckets (store logs for route53 resolver query logging)
resource "aws_s3_bucket_policy" "policy_s3Bucket_ec2logs" {
  bucket = aws_s3_bucket.ec2logs_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "CrossAccountAccess"
    Statement = [
      {
        "Sid" : "AllowListBucketFromEc2logsRole",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "s3:ListBucket"          
        ]
        "Resource" : "arn:${data.aws_partition.current.partition}:s3:::s3-company-${var.appstackcode}-${var.shortEnv}-${local.shortRegion}-ec2logs",
        "Condition" : {
          "StringEquals" : {            
            "aws:PrincipalOrgID" : "${var.ou_id}"
          },
          "ArnLike" : {
            "aws:PrincipalArn" : "arn:${data.aws_partition.current.partition}:iam::*:role/*"
          }
        }
      },
      {
        "Sid" : "AllowWriteFromEc2logsRole",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "s3:PutObject",
          "s3:GetObject"
        ]
        "Resource" : "arn:${data.aws_partition.current.partition}:s3:::s3-company-${var.appstackcode}-${var.shortEnv}-${local.shortRegion}-ec2logs/*",
        "Condition" : {
          "StringEquals" : {
            "aws:PrincipalOrgID" : "${var.ou_id}"
          },
          "ArnLike" : {
            "aws:PrincipalArn" : "arn:${data.aws_partition.current.partition}:iam::*:role/*"
          }
        }
      }
    ]
  })
}


## set IAM role and its policy to allow the replication to the central bucket
resource "aws_iam_policy" "policy-replication_regional_to_central_ec2logs" {
  name = "policy-${var.appstackcode}-replication_regional_to_central_ec2logs-${var.shortEnv}-${local.shortRegion}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket",
          "s3:GetObjectRetention",
          "s3:GetObjectLegalHold"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "${aws_s3_bucket.ec2logs_bucket.arn}"
        ]
      },
      {
        Action = [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectRetention",
          "s3:GetObjectLegalHold"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.ec2logs_bucket.arn}/*"
      },
      {
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ]
        Effect   = "Allow"
        Resource = "${var.central_bucket.arn}/*"
      },
      {
        Action = [
          "kms:Decrypt"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.ec2logs_bucket.arn}/*"
      },
      {
        Action = [
          "kms:Encrypt"
        ]
        Effect   = "Allow"
        Resource = "${var.central_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role" "s3-replication-role_ec2logs" {
  name = "role-${var.appstackcode}-replication_regional_to_central_ec2logs-${var.shortEnv}-${local.shortRegion}"

  ## trust relationship 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          "Service" : [
            "s3.amazonaws.com",
            "batchoperations.s3.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "customPolicy_attachment_ec2logs" {
  role       = aws_iam_role.s3-replication-role_ec2logs.name
  policy_arn = aws_iam_policy.policy-replication_regional_to_central_ec2logs.arn
}

## set up replication
resource "aws_s3_bucket_replication_configuration" "replication_ec2logs" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.versioning_config_ec2logs]

  role   = aws_iam_role.s3-replication-role_ec2logs.arn
  bucket = aws_s3_bucket.ec2logs_bucket.id

  rule {
    filter {
      prefix = ""
    }
    status = "Enabled"

    destination {
      bucket        = var.central_bucket.arn
      storage_class = "STANDARD"
    }
    delete_marker_replication {
      status = "Enabled"
    }
  }
}
#-------------------------------------------------------------------
