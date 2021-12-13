data "aws_route53_zone" "webapp" {
  count        = length(var.dns_hostedzone_domain) > 0 ? 1: 0
  name         = var.dns_hostedzone_domain
  private_zone = false
}

resource "aws_route53_record" "www" {
  count   = length(var.dns_hostedzone_domain) > 0 ? 1: 0
  zone_id = data.aws_route53_zone.webapp[count.index].zone_id
  name    = var.dns_record_value
  type    = "A"

  alias {
    name                   = aws_lb.asg_webapp.dns_name
    zone_id                = aws_lb.asg_webapp.zone_id
    evaluate_target_health = true
  }
}

#########   SSL Suport ###########
# module "acm_elb" {
#   source = "./acm"
#   elb_load_balancer_arn = aws_lb.asg_webapp.arn
#   elb_target_group_arn = aws_lb_target_group.webapp.arn
#   dns_record_value = var.dns_record_value
#   dns_hostedzone_domain = var.dns_hostedzone_domain
#   global_name_prefix = var.global_name_prefix
#   global_tag_tenant = var.global_tag_tenant
# }