variable "vpc_cidr" {
}

variable "public_subnet" { 
    type = map
}

variable "private_subnet" {
    type = map
  
}

variable "sg_ingress_rule" {
    type = list
}

variable "profile" {
}
