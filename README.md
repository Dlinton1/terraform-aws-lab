# Terraform AWS Free Tier Lab 🚀

## 📌 Overview

This project provisions AWS infrastructure using Terraform with a modular design.

It creates:

* A custom VPC (Virtual Private Cloud)
* A public subnet
* Internet connectivity (Internet Gateway + Route Table)
* An EC2 instance (Free Tier eligible)

This project follows real-world DevOps practices by using reusable modules.

---

## 🧱 Architecture

```
        ┌──────────────────────────────┐
        │            AWS               │
        │                              │
        │   ┌───────────────┐          │
        │   │     VPC       │          │
        │   │ 10.0.0.0/16   │          │
        │   └──────┬────────┘          │
        │          │                   │
        │   ┌──────▼────────┐          │
        │   │    Subnet     │          │
        │   │ 10.0.1.0/24   │          │
        │   └──────┬────────┘          │
        │          │                   │
        │   ┌──────▼────────┐          │
        │   │   EC2 (t2.micro) │       │
        │   │   Ubuntu Linux   │       │
        │   └───────────────┘          │
        │                              │
        │   Internet Gateway           │
        │         │                    │
        │         ▼                    │
        │       Internet              │
        └──────────────────────────────┘
```

---

## 📁 Project Structure

```
terraform-aws-lab/
│
├── modules/
│   ├── vpc/        # Network infrastructure
│   └── ec2/        # EC2 instance
│
├── environments/
│   └── dev/        # Deployment configuration
│
├── main.tf         # (if still present)
├── variables.tf
├── outputs.tf
└── README.md
```

---

## ⚙️ How It Works

### 1. VPC Module

Creates:

* VPC
* Subnet
* Internet Gateway
* Route Table

### 2. EC2 Module

Creates:

* EC2 instance inside the subnet

### 3. Environment (dev)

Connects everything together:

* Gets latest Ubuntu AMI
* Passes subnet from VPC → EC2

---

## 🚀 How to Run

Navigate to environment:

```
cd environments/dev
```

Initialize Terraform:

```
terraform init
```

Preview changes:

```
terraform plan
```

Apply infrastructure:

```
terraform apply
```

Destroy everything (IMPORTANT):

```
terraform destroy
```

---

## 💰 Cost

This project is designed to stay within AWS Free Tier:

* EC2: t2.micro ✅
* VPC/Subnet/IGW: Free ✅
* No NAT Gateway (avoids charges) ✅

⚠️ Always run `terraform destroy` when finished.

---

## 🧠 What I Learned

* Infrastructure as Code (Terraform)
* AWS networking basics (VPC, subnet, routing)
* Modular Terraform design
* How resources connect together
* How to safely stay in free tier

---

## 🔥 Future Improvements

* Add Security Groups (SSH/HTTP)
* Add NGINX web server
* CI/CD with GitHub Actions
* Multiple environments (dev/prod)
* Remote state (S3 + DynamoDB)

---

## 👤 Author

Dominique Linton
