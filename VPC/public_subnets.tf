
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = ["us-east-1a", "us-east-1b"][count.index]
  tags = {
    Name = "Public-Subnet-${count.index + 1}"
  }
}
