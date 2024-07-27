resource "aws_ecs_task_definition" "my_first_task" {
  family = "my-first-task"
  container_definitions = jsonencode([
    {
        "name": "my-first-task",
        "image": "${data.aws_ecr_repository.my_first_ecr_repo.repository_url}",
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ]
        "memory": 512,
        "cpu": 256,
        "neworkMode": "awsvpc"
    }
  ])
  requires_compatibilities = ["EC2"]
  network_mode = "awsvpc"
  memory = "512"
  cpu = "256"
  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
}