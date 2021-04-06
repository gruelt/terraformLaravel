provider "aws"{
	region = "eu-west-3"
}



resource "aws_instance" "bastion"{
	ami= "ami-0d6aecf0f0425f42a"
        instance_type = "t2.micro"

	tags = {
    		Name = "${var.tag}_bastion"
  	}

	key_name = var.key_pair_name

	subnet_id = aws_subnet.my-vpc-subnet.id

	associate_public_ip_address= true

	vpc_security_group_ids = [
	  aws_security_group.ssh-bastion.id
	]

}






