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
	count = 1
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

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mariadb"
  engine_version       = "10.4.13"
  instance_class       = "db.t2.micro"
  name                 =  var.tag
  username             =  var.tag
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot  = true
  publicly_accessible = false
	vpc_security_group_ids = [
	aws_security_group.mysql.id
	]

		tags = {
    		Name = "${var.tag}_mariadb"
  	}

}






