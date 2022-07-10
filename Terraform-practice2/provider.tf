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