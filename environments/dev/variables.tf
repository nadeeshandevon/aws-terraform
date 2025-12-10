variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cidr_block" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
