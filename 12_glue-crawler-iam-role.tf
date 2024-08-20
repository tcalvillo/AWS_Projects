# locals {
#   is_gov_resolved = var.region == "us-gov-west-1" ? true : var.is_gov
# }

resource "aws_iam_role" "glue-crawler-iam-role" {
  #count = local.is_gov_resolved ? 1 : 0
  count = var.is_gov ? 1 : 0
  name = "role-${var.appstackcode}-glue-crawler-iam-role-ec2logs-${count.index}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "glue.amazonaws.com"
          ]
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "glue-crawler-iam-policy" {
  #count = local.is_gov_resolved ? 1 : 0
  count = var.is_gov ? 1 : 0
  name   = "policy-${var.appstackcode}-glue-crawler-iam-policy-ec2logs-${count.index}"
  role   = aws_iam_role.glue-crawler-iam-role[count.index].name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:AbortMultipartUpload",
          "s3:CreateBucket",
          "s3:DeleteObject",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:PutBucketPublicAccessBlock",
          "s3:PutObject"
        ],
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-${var.shortEnv}-ec2logs-central",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-${var.shortEnv}-ec2logs-central/*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-${var.shortEnv}-${local.shortRegion}-cloudtrail-restricted/*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": ["sns:ListTopics", "sns:GetTopicAttributes"],
        "Resource": ["*"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "athena:*",
          "glue:*",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:ListRolePolicies",
          "lakeformation:GetDataAccess",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": ["*"]
      },
      {
        "Effect": "Allow",
        "Action": [
            "s3:GetObject",
            "s3:ListBucket"
        ],
        "Resource": [
          "arn:${data.aws_partition.current.partition}:s3:::crawler-public*",
          "arn:${data.aws_partition.current.partition}:s3:::aws-glue-*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:*"
        ],
        "Resource": [
          "arn:${data.aws_partition.current.partition}:ec2:*:*:network-interface/*",
          "arn:${data.aws_partition.current.partition}:ec2:*:*:security-group/*",
          "arn:${data.aws_partition.current.partition}:ec2:*:*:instance/*"
        ]
      },
      {
            "Effect": "Allow",
            "Action": [
                "glue:*",
                "s3:GetBucketLocation",
                "s3:ListBucket",
                "s3:ListAllMyBuckets",
                "s3:GetBucketAcl",
                "ec2:DescribeVpcEndpoints",
                "ec2:DescribeRouteTables",
                "ec2:CreateNetworkInterface",
                "ec2:DeleteNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcAttribute",
                "iam:ListRolePolicies",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "cloudwatch:PutMetricData"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket"
            ],
            "Resource": [
                "arn:${data.aws_partition.current.partition}:s3:::aws-glue-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:${data.aws_partition.current.partition}:s3:::aws-glue-*/*",
                "arn:${data.aws_partition.current.partition}:s3:::*/*aws-glue-*/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:${data.aws_partition.current.partition}:s3:::crawler-public*",
                "arn:${data.aws_partition.current.partition}:s3:::aws-glue-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:${data.aws_partition.current.partition}:logs:*:*:*:/aws-glue/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Condition": {
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": [
                        "aws-glue-service-resource"
                    ]
                }
            },
            "Resource": [
                "arn:${data.aws_partition.current.partition}:ec2:*:*:network-interface/*",
                "arn:${data.aws_partition.current.partition}:ec2:*:*:security-group/*",
                "arn:${data.aws_partition.current.partition}:ec2:*:*:instance/*"
            ]
        },
    ]
  })
}
