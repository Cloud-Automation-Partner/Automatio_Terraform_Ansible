terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
#module "vpc" {
#  source = "../vpc_module" # Path to the directory containing the vpc_module
#}
resource "aws_security_group" "rails_security_group" {
  vpc_id = var.vpc_id

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
  subnet_id              = element(var.subnets, 0) # Choose one of the subnets

  root_block_device {
    volume_size           = 20    # Size of the root volume in GB
    volume_type           = "gp2" # EBS volume type (e.g., gp2 for General Purpose SSD)
    delete_on_termination = true
  }

  tags = {
    Name = "Rails-Instance"
  }
}
