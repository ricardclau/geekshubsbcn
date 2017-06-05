variable "environment_name" {
  default = "prod"
}

variable "vpc_network" {
  default = "10.162.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

variable "azs" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "project" {
  default = "geekshubs"
}

variable "office_ip_cidrs" {
  default = ["0.0.0.0/0"]
}

variable "key_name" {
  default = "hlz-newinfra"
}
