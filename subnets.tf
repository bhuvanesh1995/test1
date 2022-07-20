resource "aws_subnet" "public-subnets" {
  count                   = length(var.public_cidr_block)
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = element(var.public_cidr_block, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}



resource "aws_subnet" "private-subnets" {
  count             = length(var.private_cidr_block)
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = element(var.private_cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }
}