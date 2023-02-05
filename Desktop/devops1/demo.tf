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

resource "aws_internet_gateway" "BOA-igw" {
  vpc_id = aws_vpc.BOA.id
  tags = {
    Name = "BOA-igw"
  }
}

resource "aws_default_route_table" "BOA-default" {
  default_route_table_id = aws_vpc.BOA.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.BOA-igw.id
  }
   tags = {
    Name = "BOA-default"
  }
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

  


  


