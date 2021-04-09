#### list of vars


##Entrée DNS route 53
variable "dns"{
  type = string
  default = "mondns.org"
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


//variable "dbs"{
//        type = map(string)
//        default={
//                "dev1" = "toto"
//                "dev2" = "tata"
//#                "dev3" = "titi"
//#               "thomas" = "mypass"
//#               "rapido" = "rapidosss"
//        }
//}