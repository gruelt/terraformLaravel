#http traffic
resource "aws_security_group" "http-lemp" {
  name = "http-tera-access-group"
  description = "Allow traffic on port 80 (HTTP)"

  tags = {
    Name = "HTTP Inbound Traffic Security Group"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

#ssh traffic
resource "aws_security_group" "ssh-bastion" {
  name = "ssh-tera-access-group"
  description = "Allow traffic on port 22  (SSH)"

  tags = {
    Name = "SSH Inbound Traffic Security Group"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}