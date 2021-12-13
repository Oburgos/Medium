data "aws_route53_zone" "webapp" {
  name         = var.dns_hostedzone_domain
  private_zone = false
}

resource "aws_acm_certificate" "webapp" {
  domain_name       = var.dns_record_value
  validation_method = "DNS"

  tags = {
    Terraform = "true"
    Tenant = var.global_tag_tenant
  }
}

resource "aws_route53_record" "webapp" {
  for_each = {
    for dvo in aws_acm_certificate.webapp.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.webapp.zone_id
}

resource "aws_acm_certificate_validation" "webapp" {
  certificate_arn         = aws_acm_certificate.webapp.arn
  validation_record_fqdns = [for record in aws_route53_record.webapp : record.fqdn]
}


resource "aws_lb_listener" "front_end_https" {
  load_balancer_arn = var.elb_load_balancer_arn
  port              = "443"
  protocol          = "HTTPS"
  
  certificate_arn = aws_acm_certificate_validation.webapp.certificate_arn
  
  default_action {
    type             = "forward"
    target_group_arn = var.elb_target_group_arn
  }
}