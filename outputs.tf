output "bastion_id" {
  description = "ID of the EC2 bastion"
  value       = aws_instance.bastion.id
}

output "bastion_ip" {
  description = "IP of the EC2 bastion"
  value       = aws_instance.bastion.public_ip
}