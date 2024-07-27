module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "Converter-Lambda-Script"
  description   = "This is meant to convert files to other file types"

  create_package = false

  image_uri    = data.aws_ecr_repository.my_Lambda_ecr_repo.repository_url
  package_type = "Image"
}