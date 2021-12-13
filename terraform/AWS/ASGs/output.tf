output "http_domain" {
  value = length(var.dns_record_value) > 0 ?  "http://${var.dns_record_value}" : "http://${aws_lb.asg_webapp.dns_name}"
}