variable "elb_target_group_arn" {
  type = string
  default = ""
}

variable "elb_load_balancer_arn" {
  type = string
  default = ""
}

variable "dns_hostedzone_domain" {
  type = string
  default = ""
  description = "The hosted-zone domain to get the hosted-zone-id"
}

variable "dns_record_value" {
  type = string
  default = ""
  description = "The alias record that is going to be created pointing to the ALB. It can be equal to the domain."
}

variable "global_name_prefix" {
  type = string
  default = "myapp"
}

variable "global_tag_tenant" {
  type = string
  default = "OburgosDev"
}