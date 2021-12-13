module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name = "${var.global_name_prefix}-asg-vpc"
  cidr = "172.16.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["172.16.1.0/24", "172.16.2.0/24"]
  public_subnets  = ["172.16.101.0/24", "172.16.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Tenant = var.global_tag_tenant
  }
}

module "segurity_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "4.4.0"
  
  name        = "${var.global_name_prefix}-asg-security-group"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]


  tags = {
    Terraform = "true"
    Tenant = var.global_tag_tenant
  }
}