
output "s3Bucket_retention_days" {
  description = "The number of days of retention logs in S3 bucket"
  value       =  var.logs_s3_retention
}

output "currentId" {
  value= data.aws_caller_identity.current
}


output "s3bucketCurrentDataRegion" {
  value = data.aws_region.current.name
}


output "shortRegion" {
  value = local.shortRegion
}

output "partition" {
  value = data.aws_partition.current.partition
}

