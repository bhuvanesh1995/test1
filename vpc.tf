resource "aws_vpc" "myvpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    "Name" = "${var.vpc_name}-IGW"
  }
}

resource "aws_eip" "nat-eip" {
  vpc = true
}


resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-subnets[0].id
}