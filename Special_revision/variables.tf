

variable "az" {
    description = "define auto AZ"
    type = list
  
}



variable "key_name" {
  type = string

}


variable "ssh_description" {
  description = "ssg"
  type        = string
}


variable "port_ssh" {
  type = number
}

variable "cidr_block" {
  type = string
}

variable "web_sg" {
  type = string
}

variable "port_http" {
  type = number

}

variable "port_https" {
  type = number
}

variable "web_cidr_block" {
  type = string
}

variable "mysql_sg" {
  type = string
}

variable "port_mysql" {
  type = number
}

variable "mysql_cidr_block" {
  type = string
}

variable "egress_sg_cidr_block" {
  type = string
}

variable "instance_type" {
  type = map(any)

}


