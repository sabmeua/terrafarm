resource "aws_efs_file_system" "shared_storage" {
  creation_token = "${var.app_name}-shared"

  tags = {
    Name = "${var.app_name}-shared"
  }
}

resource "aws_efs_mount_target" "private_suba" {
  file_system_id = "${aws_efs_file_system.shared_storage.id}"
  subnet_id      = "${data.aws_subnet.private_suba.id}"
}

resource "aws_efs_mount_target" "private_subc" {
  file_system_id = "${aws_efs_file_system.shared_storage.id}"
  subnet_id      = "${data.aws_subnet.private_subc.id}"
}
