#terrafrom block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider

provider "aws" {
  region  = "us-west-2"
  profile = "tf-cli-west2"
}

#data source for AMI

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*.1-x86_64-gp2"] #you change date to *
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"] #from management console AMi Location ie owner of the AMI

}


#create an Ec2 instance of type Amazon

resource "aws_instance" "Amazon_linux2_instance" {
  ami               = data.aws_ami.amazon_linux.id #reference the data source
  instance_type     = var.instance_type["dev"]     #reference map
  availability_zone = var.az[1]
  security_groups   = ["allow_ssh", "allow_web_sg", "allow_mysql"]
  key_name          = var.key_name
  tags = {
    "Name" = var.az[1]
    "Name" = var.region[2]
  }

}

#security group creation

resource "aws_security_group" "allow_SSH" {
  name        = "allow_ssh"
  description = var.ssh_description

  ingress {
    description = "SSH"
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_sg_cidr_block]

  }

  tags = {
    Name = "ssh_sg"
  }
}

resource "aws_security_group" "allow_web_sg" {
  name        = "allow_web_sg"
  description = var.web_sg

  ingress {
    description = "http from VPC"
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = "tcp"
    cidr_blocks = [var.web_cidr_block]
  }

  ingress {
    description = "https from VPC"
    from_port   = var.port_https
    to_port     = var.port_https
    protocol    = "tcp"
    cidr_blocks = [var.web_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_sg_cidr_block]
  }

  tags = {
    Name = "http_web"
  }
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = var.mysql_sg

  ingress {
    description = "mysql from VPC"
    from_port   = var.port_mysql
    to_port     = var.port_mysql
    protocol    = "tcp"
    cidr_blocks = [var.mysql_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_sg_cidr_block]
  }

  tags = {
    Name = "http_mysql"
  }
}

#vpc creation

resource "aws_vpc" "Clovis_VPC" {
  cidr_block = "10.123.0.0/16"
  tags = {
    "Name" = "Clovis_VPC"
  }

}



