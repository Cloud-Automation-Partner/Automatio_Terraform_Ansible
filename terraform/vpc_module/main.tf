terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2" # Choose your desired region
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16" # Modify the CIDR block as needed
}

locals {
  availability_zones = ["a", "b", "c"] # Define the desired availability zones
}

resource "aws_subnet" "subnets" {
  count                   = length(local.availability_zones)
  vpc_id                  = aws_vpc.terraform_vpc.id
  availability_zone       = "us-east-2${element(local.availability_zones, count.index)}"
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "rails_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id
}

resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.rails_igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.subnets)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}