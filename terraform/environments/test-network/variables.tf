variable "environment_name" {
  default = "test"
}

variable "vpc_network" {
  default = "10.161.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

variable "azs" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}