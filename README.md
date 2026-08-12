# Cloud & DevOps Infrastructure Lab

## Overview

This project demonstrates my hands-on experience building and managing cloud infrastructure, containerized applications, monitoring solutions, databases, security automation, and DevOps workflows.

The environment was built using:

- AWS
- Terraform
- Docker
- Kubernetes
- Helm
- GitHub Actions
- Linux
- DevSecOps security tooling

The goal of this project is to simulate real-world infrastructure workflows including:

- Infrastructure as Code (IaC)
- Cloud resource provisioning
- Remote Terraform state management
- Container deployment
- Kubernetes orchestration
- Monitoring and observability
- Database management
- Security automation
- CI/CD automation

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


Local Kubernetes Lab
    │
    ▼
Docker Desktop
    │
    ▼
Kind Kubernetes Cluster
    │
    ├── Pods
    ├── Deployments
    ├── Services
    ├── ConfigMaps
    ├── Secrets
    └── Helm Releases
