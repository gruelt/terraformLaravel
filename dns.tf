


resource "aws_route53_record" "bastion_dns" {
  zone_id = var.dnsid
  name    = "bastion.${var.dnszone}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.bastion.public_ip]
}

resource "aws_route53_record" "lb_dns" {
  zone_id = var.dnsid
  name    = "www.${var.dnszone}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.myloadbalancer.dns_name]
}