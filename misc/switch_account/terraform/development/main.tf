variable "app_name" {
  default = "app"
}

variable "app_env" {
  default = "development"
}

variable "aws_profile" {
  default = "default"
}
variable "aws_default_region" {
  default = "ap-northeast-1"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_default_region
}

data "aws_caller_identity" "current" {}

module "test_fixtures" {
  source = "../text_fixtures.tf"
}
