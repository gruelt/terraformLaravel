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
	  aws_security_group.ssh-bastion.id,
		aws_security_group.all-out.id
	]

}


resource "aws_instance" "web"{
	count = 2
	ami= "ami-0d6aecf0f0425f42a"
        instance_type = "t2.micro"

	tags = {
    		Name = "${var.tag}_${count.index}_nginx"
  	}

	key_name = var.key_pair_name

	subnet_id = aws_subnet.my-vpc-subnet.id

	private_ip = "192.168.10.${count.index+10}"

	associate_public_ip_address= true



	vpc_security_group_ids = [
	  aws_security_group.ssh-bastion.id,
      aws_security_group.http-web.id,
		aws_security_group.all-out.id
	]


	#user_data = file("nginx/installnginx.sh")






}






