module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "ecs-integrated"

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
        }
      }

      load_balancer = {
        service = {
          target_group_arn = "arn:aws:elasticloadbalancing:${var.REGION}:${var.ACCOUNT_NUM}:targetgroup/bluegreentarget1/209a844cd01825a4"
          container_name   = "nginx"
          container_port   = 80
        }
      }
    }
  }

  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}