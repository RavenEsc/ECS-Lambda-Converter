resource "aws_ecs_service" "my_first_services" {
  name = "gfg-test-first-services"
  cluster = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_first_task.arn
  launch_type = "EC2"
  scheduling_strategy = "REPLICA"
  desired_count = 1

  network_configuration {
    subnets = [ aws_default_subnet.default_subnet_a.id, aws_default_subnet.default_subnet_b.id, aws_default_subnet.default_subnet_c.id ]
    assign_public_ip = false
  }
}