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
  value       = aws_instance.web.*.id
}

output "nginx_ip" {
  description = "IP of the EC2 bastion"
  value       = aws_instance.web.*.private_ip
}

output "nginx_public_ip" {
  description = "IP of the nginx"
  value       = aws_instance.web.*.public_ip
}

output "mariadb_private_endpoint" {
  description = "Endpoint mariadb"
  value    = aws_db_instance.default.endpoint
}

### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("templates/inventory.tmpl",
 {
   bastion_ip = aws_instance.bastion.public_ip,
   web_ips = aws_instance.web.*.public_ip
 }
 )
 filename = "ansible/inventory"
}

### The .env for laravel
resource "local_file" "DotEnvLaravel" {
 content = templatefile("templates/DotEnv.tmpl",
 {
   mysql_ip = aws_db_instance.default.endpoint,
   mysql_db = var.tag
   mysql_user = var.tag
   mysql_password = var.db_password
   app_name = var.tag
 }
 )
 filename = "ansible/files/.env"
}

