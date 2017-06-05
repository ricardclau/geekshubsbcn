variable "environment_name" {
  default = "prod"
}

variable "region" {
  default = "eu-west-1"
}

variable "network_state" {
  default = {
    bucket = "holaluz-terraform"
    region = "eu-west-1"
    key    = "prod-network/terraform.tfstate"
  }
}

variable "project" {
  default = "geekshubs"
}

variable "key_name" {
  default = "hlz-newinfra"
}