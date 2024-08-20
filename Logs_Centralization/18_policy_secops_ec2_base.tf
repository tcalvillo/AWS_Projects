resource "aws_iam_policy" "policy-secops-ec2base-usgov" {
  count = var.is_gov ? 1 : 0
  name = "policy-secops-ec2base-usgov"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Get*",
          "s3:Head*",
          "s3:List*"
        ]
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::s3-company",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company/ec2 ",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company/ec2/*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company/bastion",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company/bastion/*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-crowdstrike",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-crowdstrike/*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-crowdstrike",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-crowdstrike/*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-ec2logs"
        ]
        Effect   = "Allow"
        Sid      = "AccessConfBucket"
      },
      {
        Action = [
          "s3:GetObject",
          "s3:HeadObject"
        ]
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-*-sshkeyretrieval/userskeyslist.json"
        ]
        Effect   = "Allow"
        Sid      = "AccessSSHKeyRetrievalBucket"
      },
      {
        Action = [
          "s3:GetObject*",
          "s3:PutObject*"
        ]
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-*/*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-ec2logs/AWSLogs/*/*/*/*/${var.account_id}/*"
        ]
        Effect   = "Allow"
        Sid      = "AccessFileAccessManagementBucket"
      },
      {
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = [  # NOTE: Real account ID replaced for security reason
          "arn:${data.aws_partition.current.partition}:kms:*:123456789012:key/*",  
          "arn:${data.aws_partition.current.partition}:kms:*:123456789012:key/*", 
          "arn:${data.aws_partition.current.partition}:kms:*:123456789012:key/*",  
          "arn:${data.aws_partition.current.partition}:kms:*:${var.account_id}:key/*"
        ]
        Effect   = "Allow"
        Sid      = "KMSSSHKeyRetrieval"
      },
      {
        Action = [
          "ssm:Describe*",
          "ssm:GetPa*",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:GetCommandInvocation",
          "ssm:GetManifest",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation"
        ]
        Resource = "*"
        Effect   = "Allow"
        Sid      = "ssmParamsMgmt"
      },
      {
        Action = [
          "ssm:SendCommand"
        ]
        Resource = [    # NOTE: Real account ID replaced for security reason
          "arn:${data.aws_partition.current.partition}:ssm:*:123456789012:document/*",
          "arn:${data.aws_partition.current.partition}:ssm:*::document/AWS-ConfigureAWSPackage",
          "arn:${data.aws_partition.current.partition}:ssm:*:${var.account_id}:managed-instance/*",
          "arn:${data.aws_partition.current.partition}:ec2:*:${var.account_id}:instance/*"
        ]
        Effect   = "Allow"
        Sid      = "PackageDistributor"
      },
      {
        Action = [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeTags",
          "ec2:DescribeImages",
          "ec2:DescribeVpcs",
          "ec2:DescribeRegions",
          "ec2:DescribeVpcEndpoints"
        ]
        Resource = "*"
        Effect   = "Allow"
        Sid      = "ec2Mgmt"
      },
      {
        Action = [
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
        Effect   = "Allow"
        Sid      = "cloudwatchMeticsMgmt"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:PutRetentionPolicy"
        ]
        Resource = "*"
        Effect   = "Allow"
        Sid      = "cloudwatchLogsMgmt"
      },
      {
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetEncryptionConfiguration"
        ]
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-centralized-ssmlogging",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-centralized-ssmlogging/*",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-ssmlogging",
          "arn:${data.aws_partition.current.partition}:s3:::s3-company-appstackcode-p-*-ssmlogging/*"
        ]
        Effect   = "Allow"
        Sid      = "SSMtoS3Logging"
      },
      {
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
          "ssm:UpdateInstanceInformation",
          "ssm:DescribeInstanceInformation"
        ]
        Resource = "*"
        Effect   = "Allow"
        Sid      = "SSMMessagesRights"
      },
      {
        Action = [
          "cloudformation:ListExports"
        ]
        Resource = "*"
        Effect   = "Allow"
        Sid      = "ListExportsCloudformation"
      },
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [  # NOTE: Real account ID replaced for security reason
          "arn:${data.aws_partition.current.partition}:secretsmanager:*:123456789012:secret:*",
          "arn:${data.aws_partition.current.partition}:secretsmanager:*:123456789012:secret:*"
        ]
        Effect   = "Allow"
        Sid      = "SecretsManagerWazCy"
      }
    ]
  })
}

