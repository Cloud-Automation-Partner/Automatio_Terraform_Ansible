# AWS Infrastructure Provisioning and Deployment with Terraform and Ansible

## Introduction

This README serves as a comprehensive guide for an Infrastructure as Code (IAC) project that leverages the power of Terraform and Ansible. The project focuses on establishing an AWS infrastructure encompassing a VPC and EC2 instances and detailing the migration of a Rails and Vue.js application from a traditional server setup to a containerized environment managed by Docker.

### Current Architecture Before Transformation

![image_2023_10_23T12_19_49_613Z](https://github.com/zahid-mahmood-devops/Automation_Terraform_Ansible/assets/148323748/c1169a7c-5985-49ef-810c-c9c99d0b66d9)

## Infrastructure Provisioning

**Terraform** is used to automate the creation of the AWS resources, including a VPC, EC2 instances, and additional necessary components.

### AWS Infrastructure to be created:

![Final Diagram](https://github.com/zahid-mahmood-devops/Automation_Terraform_Ansible/assets/148323748/f06a9145-865d-4085-9acd-e1e54d125471)

## Application Deployment

**Ansible** handles the configuration of Linux servers on the EC2 instances, installing Docker, and managing the deployment of the Rails and Vue.js applications within Docker containers.

## Application Containerization

**Docker** encapsulates the application, ensuring consistency across various environments and simplifying the deployment process.

## Prerequisites

To proceed with this project, you should have:

- An AWS account with the appropriate access
- Docker and Docker Compose installed, along with a Docker Hub account
- A GitHub account for source control management
- Terraform installed on your local machine ([Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
- Ansible installed on your local machine
- Familiarity with Terraform, Ansible, AWS, Docker, Rails, and Vue.js

## Project Structure

We will migrate a Rails, Vue.js, Redis, and PostgreSQL application to AWS, using Terraform for infrastructure definition and Ansible for configuration management. Docker Compose will be used to set up and configure the application.

![image_2023_10_23T12_18_27_969Z](https://github.com/zahid-mahmood-devops/Automation_Terraform_Ansible/assets/148323748/208f76f9-b475-4216-b516-b4848945077a)

### Getting Started

#### Docker Hub Account

Ensure your Docker Hub account is ready. Login with:

```sh
docker login
```

#### AWS Account

Install the AWS CLI and configure your AWS credentials:

```sh
aws configure
```

#### GitHub Account

Clone your repository and the project to your local machine:

```sh
git clone git/your/repo
git clone git@github.com:zahid-mahmood-devops/Automation_Terraform_Ansible.git
```

#### Docker Images

Copy the Docker files to your projects and modify them according to your needs:

```sh
cp Dockerfile-frontend /path/to/your/frontend/project/Dockerfile
cp Dockerfile-backend /path/to/your/backend/project/Dockerfile
cp docker-compose.yml /path/to/your/project/
cp deploy.sh /path/to/your/project/
```

Run the deployment script to build and push the images to Docker Hub:

```sh
./deploy.sh
```

#### Terraform Configuration

To create a new VPC with subnets:

```sh
cd /Automation_Terraform_Ansible/terraform/vpc_module  
terraform init  
terraform fmt  
terraform validate  
terraform plan  
terraform apply  # Confirm with "yes"
```

Capture the output details for subnet and VPC.

To create EC2 instances and a security group:

```sh
cd ../ec2_module
# Edit variable.tf with your VPC and subnet details
terraform init
terraform fmt 
terraform validate
terraform plan
terraform apply  # Confirm with "yes"
```

#### Ansible Configuration

Configure hosts with the IP addresses obtained from Terraform:

```sh
cd ../../ansible
vim hosts  # Add IPs for the DB and App instances
```

Set up the Ansible vault for Docker Hub credentials:

```sh
ansible-vault create docker_hub_credentials.yml
```

Run the playbooks to configure the servers:

```sh
ansible-playbook install_docker.yml --ask-vault-pass -i hosts
ansible-playbook deploy_app.yml --ask-vault-pass -i hosts
ansible-playbook deploy_db.yml --ask-vault-pass -i hosts
```

Access the application by entering the App server IP in your browser.

## Troubleshooting

Refer to this section for common issues and their solutions.

## Contributing

Guidelines for contributing to this project and reporting issues.

## License

This project is licensed under [INSERT LICENSE HERE], which details the terms and conditions of use.

---
