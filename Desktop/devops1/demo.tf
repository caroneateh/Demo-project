terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "BOA" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "BOA"
  }
}

resource "aws_subnet" "BOA-private" {
  vpc_id     = aws_vpc.BOA.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "BOA-private"
  }
}

data "aws_vpc" "Default" {
  id = "vpc-099024c870ce860ba"
}

resource "aws_subnet" "Default-1" {
  vpc_id            = data.aws_vpc.Default.id
  availability_zone = var.availability_zone
  cidr_block        = "172.31.128.0/24"
}

output "vpc-cidr" {
    value = aws_vpc.BOA.id
  }

  output "vpc-subnet" {
    value = aws_subnet.BOA-private.id
  }

  variable "vpc_cidr_block" {
    description = "vpc cidr block"
  }

  variable "subnet_cidr_block" {
    description = "subnet cidr block"
  }

  variable "availability_zone" {
    description = "availability zone"
  }


  


