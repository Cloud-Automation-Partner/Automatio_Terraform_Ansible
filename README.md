# AWS Infrastructure Provisioning and Application Deployment with Terraform and Ansible

## Introduction

This README provides comprehensive documentation for an Infrastructure as Code (IAC) project that leverages Terraform and Ansible to create, configure, and deploy an AWS infrastructure, including a Virtual Private Cloud (VPC) and EC2 instances. Additionally, it details the process of migrating an existing Rails and Vue.js application running on a simple server to the IAC-based infrastructure using Terraform and Ansible, with Docker as the containerization solution.

## Project Overview
Current architecture before transformation
![image_2023_10_23T12_19_49_613Z](https://github.com/zahid-mahmood-devops/Automation_Terraform_Ansible/assets/148323748/c1169a7c-5985-49ef-810c-c9c99d0b66d9)


### Infrastructure Provisioning
- **Terraform**: The infrastructure provisioning phase utilizes Terraform to define and create the AWS resources. We automate the creation of a VPC, EC2 instances, and other necessary components.

### Application Deployment
- **Ansible**: Ansible is employed to configure the Linux servers within the EC2 instances, ensuring that Docker is installed and set up correctly. It is also responsible for deploying and managing the Rails and Vue.js-based application within Docker containers.

### Application Containerization
- **Docker**:
## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Structure](#project-structure)
3. [Terraform Configuration](#terraform-configuration) 
4. [Ansible Configuration](#ansible-configuration)
5. [Deploying the Infrastructure](#deploying-the-infrastructure)
6. [Migrating the Application](#migrating-the-application)
7. [Running the Application](#running-the-application)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)
10. [License](#license)

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- AWS account with necessary access and secret keys.
- Docker and Docker compose installed and Docker Hub account.
- GitHub account.
- Terraform installed on your local machine, If not get [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed.
- Ansible installed on your local machine.
- Basic knowledge of Terraform, Ansible, AWS, Docker, Rails, and Vue.js.

## Project Structure
In this project, we are embarking on the migration of our Ruby on Rails, Vue.js, Redis, PostgreSQL-based application to AWS. To achieve this, we will employ Terraform to define our infrastructure as code. Configuration management will be handled using Ansible, which will facilitate the installation of Docker Compose and the configuration of the application by pulling it from GitHub
///////////////////////////////////////////////////////////////////////////////////////////////////////////
Start with:

- ## Docker Hub account:
    Add your docker hub account to use this in future if not create a new
      docker login
- ## AWS Account:
Get AWS CLI installed
Run below Command to configure your AWS account on your local machine
  aws configure
- ## Github Account:
  clone your repo to your local machine
  git clone git/your/repo
  clone this project
   git clone git@github.com:zahid-mahmood-devops/Automation_Terraform_Ansible.git
  
- ## Docker Images:
   now copy the docker files from this repo to your front-end and back-end projects respectively
  
  ...
  
     %a cp Dockerfile-frontend /path/to/your/frontend/project/Dockerfile
  ...
  
    %acp Dockerfile-backend /path/to/your/backend/project/Dockerfile
  
```
cp docker-compose.yml /path/to/your/project/
```
  
```
cp deploy.sh /path/to/your/project/
```
  
Now modify these docker and docker-compose file according to your project
once done run the below commannd to run the deploy script that will create the images of your projects and tag them to push in your docker hub repo
  ./deploy.sh
Above script will build and create the images for your project and will push these images to your docker-hub account configured earlier
Once these are done now go back to the terraform directory 
- ## Terraform:
  After installing the terraform if you want to create a new VPC along with three subnets in different availability zones then follow the below instructions or else skip to the next step
  1- Create VPC
    cd /Automation_Terraform_Ansible/terraform/vpc_module
    terraform init
    terraform fmt
    terraform validate
    terraform plan #this will show you the architecture that will be created by terraform
    terraform apply # type "yes" once it shows the architecture 
Now copy the subnet and vpc details from the output of the terraform apply copmmand
  2- Create Two EC2 linux hosts and security group
  cd ../ec2_module
  You can adjust the main.tf to add or remove the required ports in secuirity group creation section
  Now add the VPC and subnet details copied from the above output and if you have skipped the above step you can copy and paste the default VPC and default subnet details from your AWS account in variable.tf file in ec2_module folder
  you can use editors like "nano"  or "vim" to edit the variable. tf file and run below commands
  Note: PLease add the name of your key file from your AWS to the main.tf in my case it is "Test.pem" so it is in file key_name      = "Test" 
    terraform init
    terraform fmt
    terraform validate
    terraform plan #this will show you the architecture that is gonna be created by terraform
    terraform apply # type "yes" once it shows the architecture 
  After running above commands you will see terraform creating the two EC2 linux hosts and a secuirity group with allowed ports
  Now copy the both instances ip's from the output of the previous command and switch to the ansible directory and edit the hosts files
- ## Ansible:
  In this we will configure both hosts respectively
  cd ../../ansible
  vim hosts #Add the both IP's in the respective fields the one for DB-Instance and other for App instance
Once Ansible is Installed and IP's are added follow the below steps
Note: Add the key file location of your SSH key file in install_docker.yml file
create Ansible vault for docker hub credentials and add the docker hub creddentials in it
  ansible-vault create docker_hub_credentials.yml
Now when you have added the IP's in the hosts file and added docker-hub credentials in it let's run the playbooks now
  ansible-playbook install_docker.yml --ask-vault-pass -i hosts
Now you will see that serveral plays are being running and these will install docker and docker-compose in both servers and other services both the servers
Configure the app server to fetch and run the application
  ansible-playbook deploy_app.yml --ask-vault-pass -i hosts
And for DB run the below
  ansible-playbook deploy_db.yml --ask-vault-pass -i hosts


Once all plays are running successfully copy and paste the App server IP in your browser to test you application


//////////////////////////////////////////////////////////////////////////////////////////////////////////
## Terraform Configuration

Detail the Terraform configuration, including files, variables, and specific settings.

### Terraform Files

Explain the purpose of each Terraform configuration file and how they interact.

## Ansible Configuration

Discuss the Ansible setup, including playbooks, inventory files, and any specific configurations.

### Ansible Playbooks

Explain the purpose of each Ansible playbook and how they facilitate the Docker and application setup.

## Deploying the Infrastructure

Step-by-step instructions for deploying the AWS infrastructure using Terraform.
![image_2023_10_23T12_18_27_969Z](https://github.com/zahid-mahmood-devops/Automation_Terraform_Ansible/assets/148323748/208f76f9-b475-4216-b516-b4848945077a)


## Migrating the Application

Instructions for migrating your existing Rails and Vue.js application to the IAC-based infrastructure. Include any data migration steps if applicable.

## Running the Application

Guidance on how to run the Rails and Vue.js application within Docker containers on the new infrastructure.

## Troubleshooting

Common issues and their solutions.

## Contributing

Information on how to contribute to this project or report issues.

## License

Specify the project's license and any terms and conditions.

Feel free to expand on each section with detailed explanations, code examples, and any other relevant information to make your documentation comprehensive and user-friendly. Remember to keep your README.md up to date as your project evolves.
![Final Diagram](https://github.com/zahid-mahmood-devops/Automation_Terraform_Ansible/assets/148323748/f06a9145-865d-4085-9acd-e1e54d125471)
