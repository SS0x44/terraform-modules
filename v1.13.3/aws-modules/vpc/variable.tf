variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = list(string)
}

variable "public_azs" {
  type = list(string)
}

variable "private_azs" {
  type = list(string)
}
variable "vpc_name" {
  type = string
}

variable "public_subnet_name" {
  type = list(string)
}

variable "private_subnet_name" {
  type = list(string)
}

variable "public_route_name" {
  type = string
}
variable "private_route_name"  {
  type = string
}
variable "private_ngw_name" {
  type = string
}

variable "public_igw_name" {
  type = string
}
