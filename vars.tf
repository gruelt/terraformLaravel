#### list of vars


##Entrée DNS route 53
variable "dnsid"{
  type = string
  default = "Z03972671ZKB1454RWWXI"
}

##Entrée DNS route 53
variable "dnszone"{
  type = string
  default = "flipsalto.fr"
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


