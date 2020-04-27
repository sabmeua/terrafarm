variable "app_name" {
  default = "app"
}

variable "app_env" {
  default = "production"
}

variable "aws_profile" {
  default = "production"
}
variable "aws_default_region" {
  default = "ap-northeast-1"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_default_region
}

data "aws_caller_identity" "current" {}
