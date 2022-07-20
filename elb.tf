resource "aws_lb" "mylb" {
  name               = "${var.vpc_name}-mylb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = aws_subnet.public-subnets.*.id
  #subnets = [for subnet in aws_subnet.public-subnets : subnet_id]
  tags = {
    Name = "${var.vpc_name}-mylb"
  }
}


resource "aws_lb_listener" "lb-list" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}


resource "aws_lb_target_group" "lb-tg" {
  name     = "${var.vpc_name}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_target_group_attachment" "lb-tg-att" {
  count            = var.environment == "prod" ? 3 : 1
  target_group_arn = aws_lb_target_group.lb-tg.arn
  target_id        = element(aws_instance.private-instance.*.id, count.index)
  port             = 80
}

