variable "vpc_id" {}

data "aws_vpc" "local" {
  id = var.vpc_id
}

variable "subnet_public_a_id" {}
variable "subnet_public_c_id" {}

data "aws_subnet" "public_suba" {
  id = var.subnet_public_a_id
}
data "aws_subnet" "public_subc" {
  id = var.subnet_public_c_id
}

variable "subnet_private_a_id" {}
variable "subnet_private_c_id" {}

data "aws_subnet" "private_suba" {
  id = var.subnet_private_a_id
}
data "aws_subnet" "private_subc" {
  id = var.subnet_private_c_id
}
