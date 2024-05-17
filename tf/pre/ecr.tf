resource "aws_ecr_repository" "my_first_ecr_repo" {
  name = "gfg-test-ecr-repo"
  tags = {
    Name = "latest-ecr"
  }
}