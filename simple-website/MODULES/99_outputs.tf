
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

output "website_url" {
    value = aws_s3_bucket.website_bucket.website_endpoint
}

