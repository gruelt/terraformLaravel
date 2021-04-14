//resource "aws_route53_zone" "flipsalto" {
//  name = "flipsalto.fr"
//  vpc {
//    vpc_id = aws_vpc.my-vpc.id
//  }
//}
//
//resource "aws_route53_record" "www_lb" {
//  zone_id = aws_route53_zone.flipsalto.zone_id
//  name    = "www.flipsalto.fr"
//  type    = "A"
//  ttl     = "300"
//  records = ["13.36.174.125"]
//}