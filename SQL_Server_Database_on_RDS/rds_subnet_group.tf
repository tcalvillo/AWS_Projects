
# Defines which subnets RDS instances can use, assign both private subnets

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  description = "Subnet group for RDS SQL Server instances"
  subnet_ids  = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]
  tags = {
    Name = "RDS Subnet Group"
  }
}

