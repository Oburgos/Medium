resource "aws_launch_template" "webapp" {
  name_prefix              = "${var.global_name_prefix}-asg"
  image_id                 = var.ec2_image_id
  instance_type            = var.ec2_instance_type
  vpc_security_group_ids    = [module.segurity_group.security_group_id]
  
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
    }
  }

  user_data = filebase64(var.ec2_init_script_path)
}

resource "aws_autoscaling_group" "webapp" {
  name                      = "${var.global_name_prefix}-asg"
  desired_capacity          = var.asg_instances_desired
  max_size                  = var.asg_instances_max
  min_size                  = var.asg_instances_min
  vpc_zone_identifier       = module.vpc.public_subnets
  health_check_type         = "ELB"
  target_group_arns         =  [aws_lb_target_group.webapp.arn]

  launch_template {
    id      = aws_launch_template.webapp.id
    version = "$Latest"
  }
}


resource "aws_autoscaling_policy" "webapp_cpu" {
  name                    = "${var.global_name_prefix}-cpu-policy"
  adjustment_type         = "ChangeInCapacity"
  policy_type             = "TargetTrackingScaling"
  autoscaling_group_name  =  aws_autoscaling_group.webapp.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.asg_scaling_policy_cpu_target_value
  }
}