# module "cdn" {
#   source = "terraform-aws-modules/cloudfront/aws"

#   aliases = ["cdn.example.com"]

#   comment             = "The ecs CF"
#   enabled             = true
#   is_ipv6_enabled     = true
#   price_class         = "PriceClass_All"
#   retain_on_delete    = false
#   wait_for_deployment = false

#   create_origin_access_identity = true
#   origin_access_identities = {
#     s3_bucket_one = "My awesome CloudFront can access"
#   }

#   logging_config = {
#     bucket = "logs-my-cdn.s3.amazonaws.com"
#   }

#   origin = {
#     something = {
#       domain_name = "something.example.com"
#       custom_origin_config = {
#         http_port              = 80
#         https_port             = 443
#         origin_protocol_policy = "match-viewer"
#         origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
#       }
#     }

#     s3_one = {
#       domain_name = "my-s3-bycket.s3.amazonaws.com"
#       s3_origin_config = {
#         origin_access_identity = "s3_bucket_one"
#       }
#     }
#   }

#   default_cache_behavior = {
#     target_origin_id           = "something"
#     viewer_protocol_policy     = "allow-all"

#     allowed_methods = ["GET", "HEAD", "OPTIONS"]
#     cached_methods  = ["GET", "HEAD"]
#     compress        = true
#     query_string    = true
#   }

#   ordered_cache_behavior = [
#     {
#       path_pattern           = "/static/*"
#       target_origin_id       = "s3_one"
#       viewer_protocol_policy = "redirect-to-https"

#       allowed_methods = ["GET", "HEAD", "OPTIONS"]
#       cached_methods  = ["GET", "HEAD"]
#       compress        = true
#       query_string    = true
#     }
#   ]

#   viewer_certificate = {
#     acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
#     ssl_support_method  = "sni-only"
#   }
# }

# data "aws_lb" "lb" {
#   arn = module.cdn.distribution_id
# }

# resource "aws_lb_listener" "listener" {
#   load_balancer_arn = data.aws_lb.lb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = module.ecs.services["ecs-nginx"].load_balancer.service.target_group_arn
#   }
# }