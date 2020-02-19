resource "aws_ecr_repository" "php" {
  name                 = "${var.app_name}_php"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "nginx" {
  name                 = "${var.app_name}_nginx"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
