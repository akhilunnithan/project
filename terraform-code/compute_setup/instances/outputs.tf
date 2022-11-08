output "public_lb_dns_name" {
  value = aws_lb.webserver-lb.dns_name
  description="The dns name of webserver Lb"
}

output "private_lb_dns_name" {
  value = aws_lb.app-lb.dns_name
  description="The dns name of internal app Lb"
}