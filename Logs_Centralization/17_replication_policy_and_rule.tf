## set IAM role and its policy to allow the replication to the central bucket cloud trail
resource "aws_iam_policy" "policy-replication_regional_to_central_cloud_trail" {
  count = var.is_gov ? 1 : 0
  name = "policy-${var.appstackcode}-replication_regional_to_central_cloud_trail-${var.shortEnv}-${local.shortRegion}"

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
          "${aws_s3_bucket.s3_central_cloud_trail[count.index].arn}"
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
        Resource = "${aws_s3_bucket.s3_central_cloud_trail[count.index].arn}/*"
      },
      {
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.s3_central_cloud_trail[count.index].arn}/*"
      },
      {
        Action = [
          "kms:Decrypt"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.s3_central_cloud_trail[count.index].arn}/*"
      },
      {
        Action = [
          "kms:Encrypt"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.s3_central_cloud_trail[count.index].arn}/*"
      }
    ]
  })
}

resource "aws_iam_role" "s3-replication-role_cloud_trail" {
  count = var.is_gov ? 1 : 0
  name = "role-${var.appstackcode}-replication_reg_to_central_cloud_trail-${var.shortEnv}-${local.shortRegion}"

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

resource "aws_iam_role_policy_attachment" "customPolicy_attachment_cloud_trail" {
  count = var.is_gov ? 1 : 0
  role       = aws_iam_role.s3-replication-role_cloud_trail[count.index].name
  policy_arn = aws_iam_policy.policy-replication_regional_to_central_cloud_trail[count.index].arn
}