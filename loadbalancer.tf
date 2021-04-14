resource "aws_lb" "myloadbalancer" {
  name               = "${var.tag}-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http-web.id,aws_security_group.all-out.id]
  subnets            = [aws_subnet.my-vpc-subnet.id,aws_subnet.my-vpc-subnet-2.id]

  enable_deletion_protection = false



  tags = {
    Environment = "production"
  }
}


//Target group for listener
resource "aws_lb_target_group" "my-targetgroup" {
  name     = "${var.tag}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.myloadbalancer.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-targetgroup.arn
  }
}

resource "aws_alb_target_group_attachment" "groupattach" {
  for_each = {
    for inst in aws_instance.web : inst.tags.Name => inst
  }
  target_group_arn = aws_lb_target_group.my-targetgroup.arn
  target_id = each.value.id
}

