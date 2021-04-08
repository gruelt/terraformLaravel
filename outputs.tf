output "bastion_id" {
  description = "ID of the EC2 bastion"
  value       = aws_instance.bastion.id
}

output "bastion_ip" {
  description = "IP of the EC2 bastion"
  value       = aws_instance.bastion.public_ip
}


output "nginx_id" {
  description = "ID of the EC2 bastion"
  value       = aws_instance.web.id
}

output "nginx_ip" {
  description = "IP of the EC2 bastion"
  value       = aws_instance.web.private_ip
}

output "nginx_public_ip" {
  description = "IP of the nginx"
  value       = aws_instance.web.public_ip
}