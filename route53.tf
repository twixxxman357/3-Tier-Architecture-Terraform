
#make sure you change example.com to real domain name

data "aws_route53_zone" "primary" {
  name = "cloudkiller.click"

}


resource "aws_route53_record" "web_tier_record" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "cloudkiller.click"
  type    = "A"

  alias {
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true
  }
}

