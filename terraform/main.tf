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
  count         = length(aws_subnet.subnets)
  subnet_id     = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "rails_security_group" {
  vpc_id = aws_vpc.terraform_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "rails_instance" {
  ami           = "ami-0a0d9cf81c479446a" # Choose the desired AMI
  instance_type = "t2.micro"              # Choose the instance type
  key_name      = "Test"                  # Replace with your SSH key pair name

  vpc_security_group_ids = [aws_security_group.rails_security_group.id]
  subnet_id              = aws_subnet.subnets[0].id # Choose one of the subnets

  root_block_device {
    volume_size           = 20    # Size of the root volume in GB
    volume_type           = "gp2" # EBS volume type (e.g., gp2 for General Purpose SSD)
    delete_on_termination = true
  }

  tags = {
    Name = "Rails-Instance"
  }
}
