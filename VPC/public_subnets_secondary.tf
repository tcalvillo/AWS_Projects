
resource "aws_subnet" "public_secondary" {
  provider          = aws.secondary
  count             = 2
  vpc_id            = aws_vpc.secondary.id
  cidr_block        = "10.1.${count.index + 1}.0/24"
  availability_zone = ["us-west-1a", "us-west-1c"][count.index]  # Updated AZs
  tags = {
    Name = "Public-Subnet-Secondary-${count.index + 1}"
  }
}
