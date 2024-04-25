module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "ecs-ec2"

  autoscaling_capacity_providers = {
    one = {
      auto_scaling_group_arn         = "arn:aws:autoscaling:${var.REGION}:${var.ACCOUNT_NUM}:autoScalingGroup:08419a61:autoScalingGroupName/ecs-ec2-one-20220603194933774300000011"
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 5
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 60
      }

      default_capacity_provider_strategy = {
        weight = 60
        base   = 20
      }
    }
    two = {
      auto_scaling_group_arn         = "arn:aws:autoscaling:${var.REGION}:${var.ACCOUNT_NUM}:autoScalingGroup:08419a61:autoScalingGroupName/ecs-ec2-two-20220603194933774300000022"
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 15
        minimum_scaling_step_size = 5
        status                    = "ENABLED"
        target_capacity           = 90
      }

      default_capacity_provider_strategy = {
        weight = 40
      }
    }
  }

  services = {
    ecs-nginx = {
      cpu    = 256
      memory = 512

      container_definitions = {
        nginx = {
          cpu       = 256
          memory    = 512
          essential = true
          image     = "nginx:1.17"
          port_mappings = [
            {
              containerPort = 80
              protocol      = "tcp"
            }
          ]
          enable_cloudwatch_logging = false
        }
      }

      service_connect_configuration = {
        namespace = "example"
        service = {
          client_alias = {
            port     = 80
            dns_name = "ecs-sample"
          }
          port_name      = "ecs-sample"
          discovery_name = "ecs-sample"
        }
      }

      load_balancer = {
        service = {
          target_group_arn = "arn:aws:elasticloadbalancing:${var.REGION}:${var.ACCOUNT_NUM}:targetgroup/bluegreentarget1/209a844cd01825a4"
          container_name   = "nginx"
          container_port   = 80
        }
      }

      subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]

      security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = 80
          to_port                  = 80
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = "sg-12345678"
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
  
  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}