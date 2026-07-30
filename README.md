# Cloud & DevOps Infrastructure Lab

## Overview

This project demonstrates my hands-on experience building and managing cloud infrastructure, containerized applications, monitoring solutions, databases, security automation, and DevOps workflows.

The environment was built using:

* AWS
* Terraform
* Docker
* GitHub Actions
* Linux administration
* DevSecOps security tooling

The goal of this project is to simulate real-world infrastructure workflows including:

* Infrastructure as Code (IaC)
* Cloud resource provisioning
* Remote Terraform state management
* Container deployment
* Monitoring and observability
* Database management
* Security automation
* CI/CD automation

---

# Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ├── GitHub Actions
    │       │
    │       ├── Terraform Validation
    │       └── Trivy Security Scanning
    │
    ▼
AWS Cloud Infrastructure
    │
    ▼
EC2 Ubuntu Server
    │
    ▼
Docker Engine
    ├── Portainer
    ├── Uptime Kuma
    ├── Netdata
    ├── Nginx Proxy Manager
    └── PostgreSQL
```

---

# Project 1 — Terraform AWS Infrastructure

## Overview

Provisioned AWS infrastructure using Terraform Infrastructure as Code.

## Components Built

* Custom VPC
* Public subnet
* Internet Gateway
* Route table
* Security groups
* EC2 instance

## Terraform Skills Practiced

* Terraform modules
* Variables
* Outputs
* Data sources
* Resource management
* Infrastructure as Code workflows

Terraform commands practiced:

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
```

---

# Project 2 — Docker Self-Hosted Infrastructure

## Overview

Built a self-hosted Docker environment on AWS EC2 using Docker Compose.

## Services Deployed

### Portainer

Purpose:

* Docker container management
* Container logs
* Resource monitoring
* Visual administration

### Nginx Proxy Manager

Purpose:

* Reverse proxy
* Service routing
* Future SSL management

### Homepage

Purpose:

* Self-hosted application dashboard

## Docker Skills Practiced

* Docker Compose
* Container networking
* Image management
* Container lifecycle management
* Linux container administration
* Troubleshooting

---

# Project 3 — PostgreSQL Database

## Overview

Deployed PostgreSQL using Docker Compose with persistent storage.

## Technologies

* PostgreSQL 17
* Docker
* Docker Compose
* Ubuntu Linux

## Skills Practiced

* Database deployment
* Persistent volumes
* SQL fundamentals
* Containerized databases
* Application/database separation

## SQL Operations

Practiced:

* CREATE
* INSERT
* SELECT

Verified database persistence by restarting containers without losing stored data.

---

# Project 4 — Monitoring & Infrastructure Operations

## Overview

Implemented monitoring and operational visibility for the self-hosted environment.

## Monitoring Stack

### Uptime Kuma

Used for:

* Website monitoring
* Service health checks
* Availability tracking

### Netdata

Used for:

* CPU monitoring
* Memory usage
* Disk utilization
* Network metrics
* Docker container monitoring

### Nginx Proxy Manager

Used for:

* Reverse proxy management
* Centralized service access

## Skills Practiced

* Infrastructure monitoring
* Service health checks
* Linux administration
* Performance troubleshooting
* Docker operations

---

# Project 5 — Trivy DevSecOps Security Scanning

## Overview

Implemented automated vulnerability scanning using Trivy integrated with GitHub Actions.

The workflow scans container images for security vulnerabilities and blocks the workflow when high-risk issues are detected.

## Security Workflow

```text
GitHub Push
      │
      ▼
GitHub Actions Trigger
      │
      ▼
Trivy Container Scan
      │
      ▼
HIGH / CRITICAL Vulnerabilities
      │
      ├── Found → Fail Workflow
      │
      └── None → Continue
```

## Skills Practiced

* DevSecOps principles
* Container vulnerability scanning
* CVE identification
* GitHub Actions automation
* Security gates in CI/CD pipelines

---

# Project 6 — Terraform Remote State Management

## Overview

Implemented Terraform remote state management using AWS services to support team-based infrastructure workflows.

## Components Built

### Amazon S3 Backend

Used S3 to centrally store Terraform state files.

Configuration:

* Bucket: terraform-devops-state-dlinton
* Region: us-east-1
* State Key: dev/terraform.tfstate
* Encryption enabled

### DynamoDB State Locking

Implemented DynamoDB locking to prevent multiple Terraform operations from modifying infrastructure state simultaneously.

## Terraform Remote State Workflow

```text
Developer
    │
    ▼
Terraform Command
    │
    ▼
DynamoDB Lock
    │
    ▼
S3 Terraform State
    │
    ▼
AWS Infrastructure
```

## Skills Practiced

* Terraform backend configuration
* Remote state management
* State migration
* Terraform modules
* Team collaboration workflows
* Infrastructure safety practices

Commands practiced:

```bash
terraform init -migrate-state
terraform state list
terraform plan
```

---

# Tools Used

## Cloud

* AWS EC2
* AWS VPC
* Amazon S3
* Amazon DynamoDB

## Infrastructure as Code

* Terraform

## Containers

* Docker
* Docker Compose
* Portainer

## Monitoring

* Uptime Kuma
* Netdata

## Database

* PostgreSQL

## DevSecOps

* Trivy

## CI/CD

* GitHub Actions

---

# Future Roadmap

Upcoming projects:

* Kubernetes fundamentals
* Kubernetes Pods and Deployments
* Kubernetes Services
* Application scaling
* Container orchestration
* Automated Kubernetes deployments
* Multi-environment Terraform deployments
* SSL certificates
* Domain integration
* Infrastructure backups

---

# Skills Demonstrated

* AWS Cloud Infrastructure
* Linux Administration
* Terraform
* Terraform Modules
* Remote State Management
* Infrastructure as Code
* Docker
* Docker Compose
* PostgreSQL
* Monitoring & Observability
* GitHub Actions
* CI/CD Pipelines
* DevSecOps Fundamentals
* Vulnerability Scanning
* Cloud Troubleshooting
* Infrastructure Automation
