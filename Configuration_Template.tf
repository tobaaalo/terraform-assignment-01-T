# Creating Launch Template
resource "aws_launch_configuration" "web" {
  name_prefix = "web"

  image_id      = data.aws_ssm_parameter.instance_ami.value
  instance_type = var.instance_type
  key_name      = var.keyname

  security_groups             = ["${aws_security_group.ELB_SG.id}"]
  associate_public_ip_address = true
  user_data                   = file("data.sh")

  lifecycle {
    create_before_destroy = true
  }
}
