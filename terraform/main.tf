provider "aws" {
  region = "us-east-2" # Choose your desired region
}

module "vpc" {
  source = "./vpc_module" # The path to your vpc.tf file
}

module "ec2" {
  source = "./ec2_module"    # The path to your ec2.tf file
  vpc_id = module.vpc.vpc_id # Reference the output variable from the vpc module
  subnets = module.vpc.subnets
}
