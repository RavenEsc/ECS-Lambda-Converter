variable "region" {
    type = string
    default = "us-east-1"
    description = "The region that the code is deployed in"
}

variable "acc_num" {
    type = string
    default = "464004139021"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}