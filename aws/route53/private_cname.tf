data "aws_route53_zone" "local" {
  name         = "local."
  private_zone = true
}

resource "aws_route53_record" "rds_app_db" {
  zone_id = data.aws_route53_zone.local.zone_id
  name    = "${var.app_name}-db.${data.aws_route53_zone.local.name}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.app_db.address]
}
