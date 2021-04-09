#http traffic
resource "aws_security_group" "http-web" {
  name = "http-tera-access-group"
  description = "Allow traffic on port 80 (HTTP)"
  vpc_id = aws_vpc.my-vpc.id
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
    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }



}

#ssh traffic
resource "aws_security_group" "ssh-bastion" {
  name = "ssh-bastion-access-group"
  description = "Allow traffic on port 22  (SSH)"
  vpc_id = aws_vpc.my-vpc.id

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

#all out
resource "aws_security_group" "all-out" {
   name = "all-out-access-group"
  description = "Allow outport 22  (SSH)"
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "all outbound Traffic Security Group "
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "mysql" {
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = [aws_vpc.my-vpc.cidr_block]
  }


}



