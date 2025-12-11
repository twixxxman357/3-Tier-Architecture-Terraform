
#make sure you change example.com to real domain name

resource "aws_route53_zone" "my_zone" {
  name = "cloudkiller.click"
}

resource "aws_route53_record" "web_tier_record" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "web-tier"
  type    = "A"

  alias {
    name                   = aws_elb.web_tier_elb.dns_name
    zone_id                = aws_elb.web_tier_elb.zone_id
    evaluate_target_health = false
  }
}

