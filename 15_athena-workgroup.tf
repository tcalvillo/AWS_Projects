resource "aws_athena_workgroup" "athena_workgroup" {
  #count = local.is_gov_resolved ? 1 : 0
  count = var.is_gov ? 1 : 0
  name = "athenawg-${var.bl}-${var.shortEnv}-${var.default_region}-${var.appstackcode}-workgroup-ec2logs-${count.index}"

  configuration {
    enforce_workgroup_configuration    = true
     publish_cloudwatch_metrics_enabled = false

    result_configuration {
      output_location = "s3://${aws_s3_bucket.ec2logs_central_bucket.bucket}"

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
}