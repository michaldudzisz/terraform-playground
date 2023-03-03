provider "aws" {
  region = "eu-central-1"
}

variable "subnet_cidr_block" {
  description: "subnet cidr block"
}

variable "vpc_cidr_block" {
  description: "vpc cidr block"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.subnet_cidr_block
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name: "subnet-1-dev"
  }
}

data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "eu-central-1a"
  tags = {
    Name: "subnet-2-dev"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}