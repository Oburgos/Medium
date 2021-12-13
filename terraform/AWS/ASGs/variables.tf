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

variable "ssl_enabled" {
  type = bool
  default = false
}

variable "ec2_image_id" {
  type = string
  default = "ami-083654bd07b5da81d"
  description = "The id of the machine image (AMI) to use for the server. By default is Ubuntu 20"
}

variable "ec2_instance_type" {
  type = string
  default = "t3.micro"
  description = "The type of instance for your ASG. By default is t3.micro"
}

variable "ec2_init_script_path" {
  type = string
  default = "./scripts/install.sh"
  description = "Script path to run when the instance init"
}

variable "asg_instances_max" {
  type = number
  default = 2
  description = "The max quantity of intances that you desired"
}

variable "asg_instances_min" {
  type = number
  default = 1
  description = "The min quantity of intances that you desired"
}

variable "asg_instances_desired" {
  type = number
  default = 2
  description = "The intial capacity that you want"
}

variable "asg_scaling_policy_cpu_target_value" {
  type = number
  default = 40.0
  description = "The cpu target value in percentage to scale the desired capacity."
}


variable "aws_info" {
  type = map(string)
  default = {
    profile = "default"
    region = "us-east-1"
  }
}

variable "global_name_prefix" {
  type = string
  default = "myapp"
}

variable "global_tag_tenant" {
  type = string
  default = "OburgosDev"
}