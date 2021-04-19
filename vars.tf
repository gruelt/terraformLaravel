#### list of vars


##Entrée DNS route 53 de la zone
variable "dnsid"{
  type = string
  default = "Z03972671ZKB1454RWWXI"
}

##Entrée DNS route 53
variable "dnszone"{
  type = string
  default = "flipsalto.fr"
}

##Id du certificat
variable "certid"{
  type = string
  default = "arn:aws:acm:eu-west-3:042209311511:certificate/69abb56d-e3de-4d93-9d76-edfcab3d0874"
}

##tag global projet
variable "tag"{
  type = string
  default = "mars"
}

variable "key_pair_name"{
  type = string
  default = "devtest"
}

variable "db_password"{
  type = string
  default = "changeme"
}


