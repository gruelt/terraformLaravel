provider "aws"{
	region = "eu-west-3"
}



resource "aws_instance" "bastion"{
	ami= "ami-0d6aecf0f0425f42a"
        instance_type = "t2.micro"

	tags = {
    		Name = "${var.tag}_bastion"
  	}

	associate_public_ip_address= true

	vpc_security_group_ids = [
	  aws_security_group.ssh-bastion.id
	]

}



