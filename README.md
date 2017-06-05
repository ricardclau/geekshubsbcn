This repo contains some examples for building AWS AMIs and VirtualBox templates using Packer

It also contains Terraform code to create secure VPCs in AWS

Packer
======

## Folder structure

The packer code is structured as follows:

- **bootstrap**: This folder contains bootstrap scripts for AWS and Virtualbox.
- **provisioners**: This folder contains provisioning Powershell scripts, Ansible playbooks, etc.

## How to use the templates

- Download Packer following the instructions at https://www.packer.io/

### VirtualBox

- Install Virtualbox in your computer
- Run `packer build virtualbox-ubuntu16.json` or `packer build virtualbox-win2012.json`

If you are testing Windows 2012, start with the no-updates version of Autounattend.xml and when you are comfortable with the workflow and want to actually build a fully patched version, swap the autounattend variable to the one including Windows updates. The whole process will take about 2.5h!

### AWS AMIs

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

## Folder structure

The Terraform code is divided into 2 folders: Environments and modules

### Environments
- 2 environments: test and prod
- Different states for both the network setup (less likely to change) and the app setup

### Modules 
- 2 modules: `vpc-public-private` and `apache_app`
- The network module consists of: 1 VPC, 3 Public Subnets, 3 Private Subnets, 3 NAT Gateways and a Bastion Server
- The app module will use the network module outputs to create a small APP with an ELB in the public networks and an autoscaling group of Apache servers in the private networks

### How to run setups

In each of the network environment folders: 

- Modify variables.tf as needed
- terraform init to initialize the s3 remote state and dynamodb lock
- terraform plan to validate what is going to happen
- terraform apply

Beware that the nats, ec2 instances and ebs volumens and network traffic are not for free so if you want to tear it down just run:

- terraform destroy


