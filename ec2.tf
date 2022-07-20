resource "aws_instance" "public-instance" {
  count = var.environment == "prod" ? 3 : 1
  #count = length (var.public_cidr_block)
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.keypair
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true
  user_data                   = <<-EOF
  #!/bin/bash
  sudo apt-get -y update
  sudo apt-get -y install nginx
  echo "<div><h1>${var.vpc_name}-Public-Server-${count.index + 1}</h1></div>" > /var/www/html/index.nginx-debian.html
  EOF
  tags = {
    Name = "${var.vpc_name}-public-instance-${count.index + 1}"
  }
}


resource "aws_instance" "private-instance" {
  count                       = var.environment == "prod" ? 3 : 1
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.keypair
  subnet_id                   = element(aws_subnet.private-subnets.*.id, count.index)
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = false
  user_data                   = <<-EOF
  #!/bin/bash
  sudo apt-get -y update
  sudo apt-get -y install nginx
  echo "<div><h1>${var.vpc_name}-Private-Server-${count.index + 1}</h1></div>" > /var/www/html/index.nginx-debian.html
  EOF

  depends_on = [
    aws_nat_gateway.NGW
  ]

  tags = {
    Name = "${var.vpc_name}-private-instance-${count.index + 1}"
  }

}