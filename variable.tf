variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_count" {
  type = number
  default = "3"
}

variable "environment" {
  default = "dev"
}

variable "product" {
  default = "jenkins"
}