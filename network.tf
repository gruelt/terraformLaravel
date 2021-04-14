#Création d'une ressource "my-vpc" qui utilise des adresses ip en 192.168.0.0/24, donc de
#192.168.0.0 à 192.168.0.254 (l'adresse 192.168.0.255 étant celle de broadcast).
resource "aws_vpc" "my-vpc" {
  cidr_block = "192.168.0.0/16"
  #Desactiver les noms d'hôtes DNS (false par défaut, redondant).
  enable_dns_hostnames = false
  #Activer le support DNS (true par défaut, redondant).
  enable_dns_support = true
  #Gestion de l'instance, par défaut. Possible d'avoir un VPC "dedicated", mais nettement plus cher.
  instance_tenancy = "default"

  #Tags, un système clé:valeur au choix pour trier ses ressources.
  tags = {
    Name = "${var.tag}-vpc"
  }
}




#gateway internet reliée au vpc
resource "aws_internet_gateway" "my-vpc-iwg" {
  #Référence au nom du VPC
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "${var.tag}-vpc-iwg"
  }
}


#Ajout du subnet désiré
resource "aws_subnet" "my-vpc-subnet" {
  #A nouveau, le VPC dans lequel on crée le subnet. On préfère une référence à hard-coder le
  #nom du VPC, ce qui rend les changements faciles.
  vpc_id                  = aws_vpc.my-vpc.id
  #Ce subnet prend tout l'espace CIDR du VPC
  cidr_block              = "192.168.10.0/24"

  availability_zone = "eu-west-3a"

  #Ce paramètre permet de faire en sorte qu'une instance lancée dans ce subnet n'a, par défaut, pas
  #d'IP publique sauf si autrement spécifié.
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tag}-public-vpc-subnet"
  }
}

#Ajout du subnet désiré
resource "aws_subnet" "my-vpc-subnet-2" {
  #A nouveau, le VPC dans lequel on crée le subnet. On préfère une référence à hard-coder le
  #nom du VPC, ce qui rend les changements faciles.
  vpc_id                  = aws_vpc.my-vpc.id
  #Ce subnet prend tout l'espace CIDR du VPC
  cidr_block              = "192.168.30.0/24"

  availability_zone = "eu-west-3b"

  #Ce paramètre permet de faire en sorte qu'une instance lancée dans ce subnet n'a, par défaut, pas
  #d'IP publique sauf si autrement spécifié.
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tag}-public-vpc-subnet"
  }
}

#Ajout du subnet dbs
resource "aws_subnet" "my-vpc-subnet-db" {
  #A nouveau, le VPC dans lequel on crée le subnet. On préfère une référence à hard-coder le
  #nom du VPC, ce qui rend les changements faciles.
  vpc_id                  = aws_vpc.my-vpc.id
  #Ce subnet prend tout l'espace CIDR du VPC
  cidr_block              = "192.168.20.0/24"

  availability_zone = "eu-west-3b"

  #Ce paramètre permet de faire en sorte qu'une instance lancée dans ce subnet n'a, par défaut, pas
  #d'IP publique sauf si autrement spécifié.
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tag}-public-vpc-subnet-db"
  }
}




#On crée une table de routage afin de garantir que les paquets soient envoyés sur internet
resource "aws_route_table" "my-vpc-routing-table" {
  #Il est bien sûr possible de créer plusieurs routes
  route {
    #Tous les packets
    cidr_block = "0.0.0.0/0"
    #Redirigés vers l'internet gateway
    gateway_id = aws_internet_gateway.my-vpc-iwg.id
  }
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "${var.tag}-routing-table"
  }
}


#lien table de routage obligatoire
resource "aws_route_table_association" "my-vpc-routing-table-association" {
  #On associe le subnet créé...
  subnet_id      = aws_subnet.my-vpc-subnet.id
  #Avec la table de routage précédente.
  route_table_id = aws_route_table.my-vpc-routing-table.id
}


#subnet des dbs
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "mariadb_db_subnet_group_${var.tag}"
  subnet_ids = [aws_subnet.my-vpc-subnet.id,aws_subnet.my-vpc-subnet-db.id]


}
