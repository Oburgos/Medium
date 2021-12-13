# AWS Auto Scaling Groups with Terraform

Terraform project to create and ASG with custom domain and SSL capabilities, by default the script install a chat app that uses NodeJS.

### Resources

- VPC with 2 public subnets and 2 private subnets ["172.16.1.0/24", "172.16.2.0/24"]
- Security group with the 80 and 443 ports open to CIDRs [0.0.0.0/0]
- Route53 record
- ACM certificate with custom domain
- Application Load Balancer with HTTP and HTTPS
- Auto Scaling Group with: Launch Template and Scale Policy CPU based

### Variables

The default variables file is in "./vars/test.tfvars"

| Variable                            | Description                                                                                                                                                    | Default Value                                |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| global_name_prefix                  | The prefix name to all resources                                                                                                                               | chatapp                                      |
| global_tag_tenant                   | Tenant tag value                                                                                                                                               | oburgos                                      |
| aws_info                            | Map with the profile and region info                                                                                                                           | { profile = "default" region = "us-east-1" } |
| ec2_image_id                        | he id of the machine image (AMI) to use for the server. By default is Ubuntu 20.04                                                                             | ami-083654bd07b5da81d                        |
| ec2_instance_type                   | The type of instance for your ASG. By default is t3.micro                                                                                                      | t3.micro                                     |
| ec2_init_script_path                | Script path to run when the instance starts                                                                                                                    | "./scripts/install.sh                        |
| asg_instances_max                   | The max quantity of intances that you desired                                                                                                                  | 4                                            |
| asg_instances_desired               | The intial capacity that you want                                                                                                                              | 1                                            |
| asg_instances_min                   | The min quantity of intances that you desired                                                                                                                  | 1                                            |
| asg_scaling_policy_cpu_target_value | The cpu target value in percentage to scale.                                                                                                                   | 40.0                                         |
| dns_hostedzone_domain               | (optional) This value is used to find the Hosted Zone in Route53                                                                                               | ""                                           |
| dns_record_value                    | (optional) (Must if set dns_hostedzone_domain) The alias record that is going to be created pointing to the ALB. It can be equal to the domain or a sub-domain | ""                                           |

### How to use

**Important**:
To enable the SSL support uncoment the module **acm_elb** in custom-domain.tf and set the variables **dns_hostedzone_domain** and **dns_record_value**.

To run this project execute the next commands:

```
git clone https://github.com/Oburgos/Medium.git
cd ./Oburgos/Medium/terraform/AWS/ASGs
terraform init
terraform apply -var-file="./vars/test.tfvars"
```

To destroy the resources:

```
terraform destroy -var-file="./vars/test.tfvars"
```
