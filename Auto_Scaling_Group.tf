#Creating Auto Scaling Group
resource "aws_autoscaling_group" "web" {
  name = "${aws_launch_template.web.name}-asg"

  min_size         = 3
  desired_capacity = 3
  max_size         = 3

  health_check_type = "ELB"
  load_balancers = [
    aws_elb.web_elb.id
  ]

  # Using launch template instead of launch configuration
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier = [
    aws_subnet.terraform_public_subnet01.id,
    aws_subnet.terraform_public_subnet02.id
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}
