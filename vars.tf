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