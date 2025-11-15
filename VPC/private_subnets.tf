resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 3}.0/24"
  availability_zone = ["us-east-1a", "us-east-1b"][count.index]
  tags = {
    Name = "Private-Subnet-${count.index + 1}"
  }
}
