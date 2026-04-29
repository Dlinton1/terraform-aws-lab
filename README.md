# Terraform AWS Free Tier Lab

## 📌 Overview
This project provisions a basic AWS infrastructure using Terraform, following Infrastructure as Code (IaC) principles.

The environment includes:
- A custom VPC
- A public subnet
- Internet Gateway and route table
- A free-tier EC2 instance

All resources are designed to stay within the AWS Free Tier when used correctly.

---

## 🛠️ Technologies Used
- Terraform
- AWS (EC2, VPC, Networking)
- Git & GitHub
- SSH Authentication

---

## 🧱 Architecture
Terraform provisions the following:

1. VPC (10.0.0.0/16)
2. Public Subnet (10.0.1.0/24)
3. Internet Gateway (for internet access)
4. Route Table + Association
5. EC2 Instance (t2.micro - Free Tier)

---

## 🚀 How to Run

### 1. Initialize Terraform
bash terraform init 

### 2. Preview changes
bash terraform plan 

### 3. Apply infrastructure
bash terraform apply 

Type yes when prompted.

---

## 🧹 Destroy Resources (IMPORTANT)
To avoid charges:

bash terraform destroy 

---

## 💰 Cost Notes
- Uses AWS Free Tier eligible resources
- EC2 instance is t2.micro
- No NAT Gateway or paid services included

⚠️ Always destroy resources after testing

---

## 🎯 What I Learned
- Infrastructure as Code using Terraform
- AWS networking basics (VPC, subnets, routing)
- Managing cloud resources safely within free tier
- Git & SSH workflow for DevOps projects

---

## 📎 Future Improvements
- Convert into reusable Terraform modules
- Add multiple environments (dev/prod)
- Implement CI/CD using GitHub Action
