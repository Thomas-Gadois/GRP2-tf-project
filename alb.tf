# alb.tf

# Création de l'Application Load Balancer
resource "aws_lb" "GRP2-alb" {
  name               = "GRP2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_default_security_group.GRP2-security-rule.id]
  subnets            = aws_subnet.GRP2-public-subnet[*].id

  enable_deletion_protection = false

  tags = {
    Name = "GRP2-alb"
  }
}

# Création du Target Group pour l'ALB
resource "aws_lb_target_group" "GRP2-tg" {
  name        = "GRP2-tg"
  port        = 31000  # Choisir un port dans la plage 30000-32767
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc_name.id
  target_type = "instance" 

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    path                = "/healthz"
    interval            = 30
    port                = "traffic-port"
  }
}

# Création du Listener pour l'ALB
resource "aws_lb_listener" "GRP2-alb-listener" {
  load_balancer_arn = aws_lb.GRP2-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.GRP2-tg.arn
  }
}
