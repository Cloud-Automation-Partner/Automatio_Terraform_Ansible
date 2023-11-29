# AWS Infrastructure Provisioning and Deployment with Terraform and Ansible

## Introduction

This README serves as a comprehensive guide for an Infrastructure as Code (IAC) project that leverages the power of Terraform and Ansible. The project focuses on establishing an AWS infrastructure encompassing a VPC and EC2 instances and detailing the migration of a Rails and Vue.js application from a traditional server setup to a containerized environment managed by Docker.

### Current Architecture Before Transformation

<img width="800" src="https://github.com/Cloud-Automation-Partner/Automatio_Terraform_Ansible/assets/151637997/4e8209cf-4b36-439c-b3ef-68f702db4c9f">


## Infrastructure Provisioning

**Terraform** is used to automate the creation of the AWS resources, including a VPC, EC2 instances, and additional necessary components.

### AWS Infrastructure to be created:

<img width="800" src="https://github.com/Cloud-Automation-Partner/Automatio_Terraform_Ansible/assets/151637997/5c0f42e7-224a-49b8-943d-72ce826fce37">


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

<img width="800" src="https://github.com/Cloud-Automation-Partner/Automatio_Terraform_Ansible/assets/151637997/a99169b5-1f46-4902-bdca-3711c066ecac">

### Getting Started

#### Install Docker:

Please visit the link for installing Docker and Docker-Compose on AL2 OS. [Installing Docker](https://gist.github.com/npearce/6f3c7826c7499587f00957fee62f8ee9)

#### Docker Hub Account  

Verify the Installation  

```sh
docker -v
```
```sh
docker-compose -v
```

Ensure your Docker Hub account is ready. Login with:

```sh
docker login
```

#### Install AWS CLI & Login AWS Account

```sh
sudo yum Install awscli -y
```
```sh
aws configure
```

####  Install Git & Configure GitHub Account  

```sh
sudo yum Install git -y
```
```sh
git --version
```
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

#### Terraform   

##### Terraform Configuration  

Please follow the documetation for installing the Terraform on your local machine which in my case is amazon linnux 2. ([Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))  
Verify the installation by running  
```sh
terraform -help
```
     
##### Terraform Configuration

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

<img width="679" alt="Screenshot 2023-10-19 at 10 15 25 AM" src="https://github.com/Cloud-Automation-Partner/Automatio_Terraform_Ansible/assets/151637997/ea658b2e-254d-4562-bd1e-9f8b04457c28">

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

#### Ansible Installation & Configuration  

```sh
sudo yum update -y
```
```sh
sudo amazon-linux-extras install epel -y
```
```sh
sudo yum install ansible -y
```
```sh
ansible --version
```

Configure hosts with the IP addresses obtained from Terraform:  

<img width="734" alt="Screenshot 2023-10-19 at 1 36 06 PM" src="https://github.com/Cloud-Automation-Partner/Automatio_Terraform_Ansible/assets/151637997/369a348b-ae25-42e3-aa5a-97c854dea053">

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
```
Now copy the Docker-Compose files for DB and App on a location and add that location in the playbook files respectively

```sh
ansible-playbook deploy_app.yml --ask-vault-pass -i hosts
```
```sh
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
