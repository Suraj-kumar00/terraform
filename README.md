# Production Ready Terraform Configuration for AWS

<p align="center">
  <img src="https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg" alt="Terraform" width="80" height="80"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-v1.0+-623CE4?style=flat&logo=terraform" alt="Terraform"/>
  <img src="https://img.shields.io/badge/AWS-Cloud-FF9900?style=flat&logo=amazonaws" alt="AWS"/>
  <img src="https://img.shields.io/badge/IaC-Production_Ready-00C853?style=flat" alt="Production Ready"/>
</p>

Multi-environment infrastructure as code for AWS with modular, reusable Terraform configurations supporting development, staging, and production workloads.

---

## 📁 Project Structure

```
terraform/
├── environments/
│   ├── dev/          # Development environment
│   ├── staging/      # Staging environment
│   └── prod/         # Production environment
└── modules/
    ├── common/       # Shared resources
    ├── ec2/          # EC2 instances & security groups
    ├── ecr/          # Elastic Container Registry
    ├── eks/          # Elastic Kubernetes Service
    ├── iam/          # IAM roles & policies
    ├── keypair/      # SSH key management
    ├── s3/           # S3 storage buckets
    └── vpc/          # Network infrastructure
```

---

## 🔧 Prerequisites

- [Terraform](https://www.terraform.io/downloads) v1.0+
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with necessary permissions

---

## 🏗️ Modules

| Module | Description |
|--------|-------------|
| **common** | Shared resources and configurations |
| **ec2** | Instance and security group management |
| **ecr** | Elastic Container Registry for Docker images |
| **eks** | Elastic Kubernetes Service cluster management |
| **iam** | Identity and Access Management roles/policies |
| **keypair** | SSH key pair management |
| **s3** | Storage bucket with security features |
| **vpc** | Network infrastructure and routing |

---

## 🌍 Environment Specifications

| Environment | Instance Type | CIDR Block | Purpose |
|-------------|--------------|------------|---------|
| **dev** | t2.micro | 10.0.0.0/16 | Feature development & testing |
| **staging** | t2.small | 10.1.0.0/16 | Pre-production testing |
| **prod** | t2.medium | 10.2.0.0/16 | Live workloads |

---

## 🚀 Quick Start

```bash
# 1. Navigate to environment
cd environments/<env>   # dev, staging, or prod

# 2. Initialize Terraform
terraform init

# 3. Review changes
terraform plan

# 4. Apply infrastructure
terraform apply
```

---

## 🔑 Key Features

### Infrastructure Components
- VPC with public/private subnets
- EC2 instances for web and application servers
- EKS clusters for container orchestration
- ECR repositories for Docker images
- S3 buckets for storage
- IAM roles and policies

### Security Measures
- Network isolation with security groups
- IAM role-based access control
- Encryption at rest
- Public access blocking
- Least privilege principle

### Scalability
- Environment-specific resource sizing
- Modular, reusable design
- Expandable CIDR ranges

---

## 📋 Common Commands

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize working directory |
| `terraform plan` | Preview infrastructure changes |
| `terraform apply` | Create/update infrastructure |
| `terraform destroy` | Destroy all resources |
| `terraform destroy -target=TYPE.NAME` | Destroy specific resource |

> ⚠️ **Warning**: Avoid using `terraform destroy --auto-approve` in production environments.

---

## ✅ Best Practices

### Code Organization
- Modular structure with DRY principles
- Clear separation of concerns
- Environment isolation

### Security
- Network segmentation
- Resource isolation
- Access controls with encryption

### Maintainability
- Consistent naming conventions
- Environment-specific state files
- Remote backend for production
