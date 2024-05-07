# module "lambda_function_container_image" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = "Converter-Lambda-Script"
#   description   = "This is meant to convert files to other file types"

#   create_package = false

#   image_uri    = "132367819851.dkr.ecr.eu-west-1.amazonaws.com/complete-cow:1.0"
#   package_type = "Image"
# }