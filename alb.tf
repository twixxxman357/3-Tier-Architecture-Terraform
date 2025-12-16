
resource "aws_lb_target_group" "web_tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb" "frontend_alb" {
  name               = "frontend-alb"
  load_balancer_type = "application"
  internal           = false
  subnets            = aws_subnet.public_web[*].id
  security_groups    = [aws_security_group.alb_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "Frontend-ALB"
      Tier = "LoadBalancer"
    }
  )
}

resource "aws_lb" "be_alb" {
  name               = "be-alb"
  internal           = true
  load_balancer_type = "application"

  subnets         = aws_subnet.private_app[*].id
  security_groups = [aws_security_group.be_alb_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "BE-ALB"
      Tier = "LoadBalancer"
    }
  )
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "App-TG"
      Tier = "Application"
    }
  )
}

resource "aws_lb_target_group_attachment" "app_attachments" {
  count            = length(aws_instance.app)
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app[count.index].id
  port             = 80
}

resource "aws_lb_listener" "be_http" {
  load_balancer_arn = aws_lb.be_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

