terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket"
    key    = "appname/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
