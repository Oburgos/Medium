resource "aws_lb" "asg_webapp" {
  name               = "${var.global_name_prefix}-asg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.segurity_group.security_group_id]
  subnets            =  module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Terraform = "true"
    Tenant = var.global_tag_tenant
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.asg_webapp.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp.arn
  }
}

resource "aws_lb_target_group" "webapp" {
  name     = "${var.global_name_prefix}-lb-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
      port  = 5000
  }
}
