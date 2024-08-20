resource "aws_glue_crawler" "glue-crawler" {
  #count = local.is_gov_resolved ? 1 : 0
  count = var.is_gov ? 1 : 0
  database_name = aws_glue_catalog_database.glue-catalog-database[count.index].name
  name          = "gluecwl-${var.bl}-${var.shortEnv}-${var.default_region}-${var.appstackcode}-glue-crawler-ec2logs-${count.index}"
  role          = aws_iam_role.glue-crawler-iam-role[count.index].arn

  s3_target {
    path = "s3://${aws_s3_bucket.ec2logs_central_bucket.bucket}"
  }
}
