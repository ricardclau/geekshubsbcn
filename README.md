This repo contains some examples for building AWS AMIs and VirtualBox templates using Packer

It also contains Terraform code to create secure VPCs in AWS

Packer
======

# Folder structure

The packer code is structured as follows:

- **bootstrap**: This folder contains bootstrap scripts for AWS and VMWare.
- **provisioners**: This folder contains provisioning Powershell scripts, Ansible playbooks, etc.

# How to use the templates

- Download Packer following the instructions at https://www.packer.io/

## VMWare

- Install Virtualbox in your computer
- Run `packer build virtualbox-ubuntu16.json` or `packer build virtualbox-win2012.json`

## AWS AMIs

- Create a VPC with at least a subnet where you will run the instance to build the AMI
- Create a Security group allowing ports 22 (SSH for Linux boxes) and 5985-5986 (WinRM for Windows boxes)

```
resource "aws_security_group" "packer" {
  name        = "packer"
  description = "For packer AMI builds"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "packer"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
- Run `packer build -var 'aws_access_key=YOUR_KEY' -var 'aws_secret_key=YOUR_SECRET' -var 'subnet_id=subnet-XXXXXX' -var 'security_group_id=sg-YYYYYY' aws-win2012.json` or if you have the AWS CLI tool configure with an ~/.aws/credentials file you can omit the aws credentals parameters

Terraform
=========