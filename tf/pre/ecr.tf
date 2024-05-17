resource "aws_ecr_repository" "my_first_ecr_repo" {
  name = "gfg-test-ecr-repo"
  tags = {
    Name = "latest-ecs-ecr"
  }
}

resource "aws_ecr_repository" "my_Lambda_ecr_repo" {
  name = "lambda-test-ecr-repo"
  tags = {
    Name = "latest-lambda-ecr"
  }
}