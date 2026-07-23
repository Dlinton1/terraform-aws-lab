# Cloud & DevOps Infrastructure Lab

## Overview

This project demonstrates my hands-on experience building and managing cloud infrastructure, containerized applications, and DevOps automation.

The environment was built using AWS, Terraform, Docker, GitHub Actions, and Linux administration practices.

The goal of this project is to simulate real-world infrastructure workflows including:

- Infrastructure as Code (IaC)
- Cloud resource provisioning
- Container deployment
- Service monitoring
- Database management
- CI/CD automation


# Architecture

## Cloud Infrastructure

AWS EC2 Ubuntu Server



# Project 1 — Terraform AWS Infrastructure

## Overview

Provisioned AWS infrastructure using Terraform Infrastructure as Code.

## Components Built

- Custom VPC
- Public subnet
- Internet Gateway
- Route tables
- Security groups
- EC2 Ubuntu instance

## Terraform Skills Practiced

- Terraform modules
- Variables
- Outputs
- Data sources
- terraform init
- terraform validate
- terraform plan
- Terraform state management


## CI/CD Integration

GitHub Actions automatically validates Terraform changes.

Pipeline workflow:


The pipeline prevents invalid Terraform changes from being merged.


# Project 2 — Docker Self Hosted Infrastructure

## Overview

Deployed and managed containerized applications on AWS EC2 using Docker Compose.

## Services Deployed

### Portainer

Purpose:
- Container management dashboard
- Visual Docker administration


### Uptime Kuma

Purpose:
- Application uptime monitoring
- Service availability checks


### Netdata

Purpose:
- Infrastructure monitoring
- CPU, memory, disk, and network metrics


### Nginx Proxy Manager

Purpose:
- Reverse proxy management
- Future SSL certificate automation


## Docker Skills Practiced

- Container lifecycle management
- Docker Compose
- Container networking
- Image management
- Troubleshooting containers
- Reading container logs


# Project 3 — PostgreSQL Database Container

## Overview

Deployed PostgreSQL as a containerized database using Docker Compose.

## Technologies

- PostgreSQL 17
- Docker
- Docker Compose
- Ubuntu Linux


## Skills Practiced

- Database containers
- Persistent storage
- SQL fundamentals
- Application/database separation


## Database Persistence

Configured Docker volumes to ensure database data survives container restarts.

Architecture:



## SQL Operations Practiced

Created database tables:

- CREATE
- INSERT
- SELECT


Verified database persistence by stopping and restarting the PostgreSQL container.


# Tools Used

## Cloud

- AWS EC2
- AWS VPC


## Infrastructure as Code

- Terraform


## Containers

- Docker
- Docker Compose
- Portainer


## Monitoring

- Uptime Kuma
- Netdata


## Database

- PostgreSQL


## CI/CD

- GitHub Actions


# Future Improvements

Planned upgrades:

- Trivy container security scanning
- Docker image vulnerability management
- Terraform remote state using S3
- DynamoDB state locking
- Dev/Staging/Production environments
- Kubernetes deployment
- Automated application deployments


# Skills Demonstrated

- Linux administration
- Cloud infrastructure
- Infrastructure as Code
- Container management
- Monitoring
- Database administration
- CI/CD fundamentals
- DevOps troubleshooting