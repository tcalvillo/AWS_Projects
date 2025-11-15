output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "secondary_vpc_id" {
  value = aws_vpc.secondary.id
}

output "main_public_subnets" {
  value = aws_subnet.public[*].id
}

output "main_private_subnets" {
  value = aws_subnet.private[*].id
}

output "secondary_public_subnets" {
  value = aws_subnet.public_secondary[*].id
}

output "secondary_private_subnets" {
  value = aws_subnet.private_secondary[*].id
}

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.main.id
}
