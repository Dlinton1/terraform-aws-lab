# Terraform AWS Modular Infrastructure Lab

## Overview
This project demonstrates Infrastructure as Code using Terraform on AWS.

It includes:
- Modular VPC design
- Reusable EC2 module
- Security groups (SSH + HTTP access)
- GitHub Actions CI pipeline
- Free-tier safe AWS architecture

## Architecture
- VPC (custom network)
- Public Subnet
- Internet Gateway
- Route Table
- EC2 instance (Ubuntu 22.04 t2.micro)

## Tools Used
- Terraform
- AWS EC2
- AWS VPC
- GitHub Actions

## CI/CD
Every push triggers:
- terraform init
- terraform validate
- terraform plan