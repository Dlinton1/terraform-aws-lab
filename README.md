# Cloud & DevOps Infrastructure Lab

## Overview

This project demonstrates my hands-on experience building and managing cloud infrastructure, containerized applications, monitoring solutions, databases, and DevSecOps automation.

The environment was built using AWS, Terraform, Docker, GitHub Actions, and Linux administration practices.

The goal of this project is to simulate real-world infrastructure workflows including:

- Infrastructure as Code (IaC)
- Cloud resource provisioning
- Container deployment
- Monitoring and observability
- Database management
- DevSecOps
- CI/CD automation

---

# Architecture

```text
Internet
    │
    ▼
AWS EC2 (Ubuntu Linux)
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

- Custom VPC
- Public subnet
- Internet Gateway
- Route table
- Security groups
- EC2 instance

## Terraform Skills Practiced

- Terraform modules
- Variables
- Outputs
- Data sources
- terraform init
- terraform validate
- terraform plan
- Infrastructure as Code

## CI/CD

GitHub Actions automatically performs:

- terraform init
- terraform validate
- terraform plan

This ensures infrastructure changes are validated before deployment.

---

# Project 2 — Docker Self-Hosted Infrastructure

## Overview

Built a self-hosted Docker environment on AWS EC2 using Docker Compose.

## Services Deployed

### Portainer

Purpose:

- Docker container management
- Container logs
- Resource monitoring
- Visual administration

### Nginx Proxy Manager

Purpose:

- Reverse proxy
- SSL management (future)
- Host routing

### Homepage

Purpose:

- Dashboard for self-hosted applications

## Docker Skills Practiced

- Docker Compose
- Docker networking
- Container lifecycle
- Image management
- Troubleshooting
- Linux container administration

---

# Project 3 — PostgreSQL Database

## Overview

Deployed PostgreSQL using Docker Compose with persistent Docker volumes.

## Technologies

- PostgreSQL 17
- Docker
- Docker Compose
- Ubuntu Linux

## Skills Practiced

- Database deployment
- Persistent storage
- SQL fundamentals
- Docker volumes
- Application/database separation

## SQL Operations

- CREATE
- INSERT
- SELECT

Verified data persistence by restarting the PostgreSQL container without data loss.

---

# Project 4 — Monitoring & Infrastructure Operations

## Overview

Implemented infrastructure monitoring and operational dashboards for a self-hosted environment.

## Monitoring Stack

### Uptime Kuma

Purpose:

- Website monitoring
- Service availability
- Health checks
- Uptime reporting

### Netdata

Purpose:

- CPU monitoring
- Memory monitoring
- Disk utilization
- Network monitoring
- Docker container metrics

### Nginx Proxy Manager

Purpose:

- Reverse proxy management
- Centralized web access
- Future SSL certificate management

## Skills Practiced

- Infrastructure monitoring
- Service health checks
- Performance analysis
- Linux server administration
- Docker service management
- Operational troubleshooting

---

# Project 5 — Trivy Security Scanning (In Progress)

## Overview

Implementing DevSecOps security scanning using Trivy to identify vulnerabilities before deployment.

## Skills Practiced

- Vulnerability scanning
- CVE identification
- Container security
- DevSecOps
- GitHub Actions security gates

## Planned Workflow

```text
GitHub Push
      │
      ▼
Terraform Validation
      │
      ▼
Trivy Security Scan
      │
      ▼
Pass → Continue

Fail → Block Deployment
```

---

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

## DevSecOps

- Trivy (In Progress)

## CI/CD

- GitHub Actions

---

# Future Roadmap

Upcoming projects include:

- Terraform Remote State (S3)
- DynamoDB State Locking
- Multi-environment deployments (Dev / Staging / Production)
- Kubernetes
- Automated deployments
- SSL certificates
- Domain integration
- Infrastructure backups

---

# Skills Demonstrated

- AWS Cloud Infrastructure
- Linux Administration
- Terraform
- Infrastructure as Code
- Docker
- Docker Compose
- PostgreSQL
- Monitoring & Observability
- GitHub Actions
- CI/CD
- DevSecOps Fundamentals
- Infrastructure Troubleshooting
