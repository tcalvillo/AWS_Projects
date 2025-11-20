
# Automatically scales application servers, deploy across both public subnets
# Note: is specifically for EC2 instances

resource "aws_launch_template" "app_server" {
  name_prefix   = "app-server-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name      = var.key_pair_name
  user_data     = filebase64("user_data.sh")
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.vpc_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-server"
    }
  }
}

resource "aws_autoscaling_group" "app_server_asg" {
  name                = "app-server-asg"
  max_size            = 5
  min_size            = 2
  desired_capacity    = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "app-server-asg"
    propagate_at_launch = true
  }
}
