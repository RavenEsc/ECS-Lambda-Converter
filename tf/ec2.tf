resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-template"
  image_id = "ami-07caf09b362be10b8"
  instance_type = "t3.micro"

  key_name = "ecskey1"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
        volume_size = 30
        volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
        Name = "ecs-instance"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
        Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")
}

# Create the IAM Role for the ECS task
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the necessary permissions to the IAM Role
resource "aws_iam_role_policy_attachment" "ecs_task_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_task_role.name
}

# Create the IAM Instance Profile
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-profile"
  role = aws_iam_role.ecs_task_role.name
}


resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  
  launch_template {
    id = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}