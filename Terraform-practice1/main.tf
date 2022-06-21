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
  region = "us-west-2"
  profile = "tf-cli-west2"
}
#create an Ec2 instance of type Amazon
resource "aws_instance" "Amazon_linux2_instance" {
    ami = "ami-0ca285d4c2cda3300"
    instance_type = "t2.micro"
    availability_zone = "us-west-2b"
    security_groups = ["allow_ssh"]
    key_name = "Terraform_key"
    tags = {
      "Name" = "Amazon_Linux2"
    }
  
}
  
  #security group creation
resource "aws_security_group" "allow_SSH" {
  name        = "allow_ssh"
  description = "Allow ssh from my IP"
  vpc_id      = "vpc-0a14ad36b118051c4"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["174.117.135.9/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh_sg"
  }
}



#vpc creation

resource "aws_vpc" "Clovis_VPC" {
  cidr_block = "10.123.0.0/16"
  tags = {
    "Name" = "Clovis_VPC"
  }
  
}
