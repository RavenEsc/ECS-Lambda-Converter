data "aws_ecr_repository" "my_first_ecr_repo" {
    name = "gfg-test-ecr-repo"
}

data "aws_ecr_repository" "my_Lambda_ecr_repo" {
    name = "lambda-test-ecr-repo"
}