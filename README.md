# AWS Infrastructure Provisioning and Application Deployment with Terraform and Ansible

## Introduction

This README provides comprehensive documentation for an Infrastructure as Code (IAC) project that leverages Terraform and Ansible to create, configure, and deploy an AWS infrastructure, including a Virtual Private Cloud (VPC) and EC2 instances. Additionally, it details the process of migrating an existing Rails and Vue.js application running on a simple server to the IAC-based infrastructure using Terraform and Ansible, with Docker as the containerization solution.

## Project Overview
Current architecture before  transformation
![image_2023_10_23T12_19_49_613Z](https://github.com/zahid-mahmood-devops/Automation_Terraform_Ansible/assets/148323748/c1169a7c-5985-49ef-810c-c9c99d0b66d9)

### Infrastructure Provisioning
- **Terraform**: The infrastructure provisioning phase utilizes Terraform to define and create the AWS resources. We automate the creation of a VPC, EC2 instances, and other necessary components.

### Application Deployment
- **Ansible**: Ansible is employed to configure the Linux servers within the EC2 instances, ensuring that Docker is installed and set up correctly. It is also responsible for deploying and managing the Rails and Vue.js-based application within Docker containers.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Structure](#project-structure)
3. [Terraform Configuration](#terraform-configuration)
    - [Terraform Files](#terraform-files)
    - [Terraform Variables](#terraform-variables)
4. [Ansible Configuration](#ansible-configuration)
    - [Ansible Playbooks](#ansible-playbooks)
    - [Ansible Inventory](#ansible-inventory)
5. [Deploying the Infrastructure](#deploying-the-infrastructure)
6. [Migrating the Application](#migrating-the-application)
7. [Running the Application](#running-the-application)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)
10. [License](#license)

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- AWS account with necessary access and secret keys.
- Docker and Docker compose .
- Terraform installed on your local machine, If not get [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed.
- Ansible installed on your local machine.
- Basic knowledge of Terraform, Ansible, AWS, Docker, Rails, and Vue.js.

## Project Structure
In this project, we are embarking on the migration of our Ruby on Rails, Vue.js, Redis, PostgreSQL-based application to AWS. To achieve this, we will employ Terraform to define our infrastructure as code. Configuration management will be handled using Ansible, which will facilitate the installation of Docker Compose and the configuration of the application by pulling it from GitHub

## Terraform Configuration

Detail the Terraform configuration, including files, variables, and specific settings.

### Terraform Files

Explain the purpose of each Terraform configuration file and how they interact.

### Terraform Variables

Provide an overview of the Terraform variables and any user-specific configurations that need to be set.

## Ansible Configuration

Discuss the Ansible setup, including playbooks, inventory files, and any specific configurations.

### Ansible Playbooks

Explain the purpose of each Ansible playbook and how they facilitate the Docker and application setup.

### Ansible Inventory

Detail how the Ansible inventory is structured and what hosts it covers.

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
