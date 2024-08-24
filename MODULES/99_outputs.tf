
output "currentId" {
  value= data.aws_caller_identity.current
}

output "shortRegion" {
  value = local.shortRegion
}

output "partition" {
  value = data.aws_partition.current.partition
}

output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.main.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value = aws_subnet.main[*].id  
}

