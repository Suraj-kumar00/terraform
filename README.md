# Production ready terraform configruation for AWS

##  Project Overview: Terraform Multi-Environment Infrastructure

## Core Components

### 1. Environment Management
- Separate configurations for dev, staging, and prod
- Environment-specific variables
- Isolated state files
- Different resource sizes per environment

### 2. Module System
- **Common Module**: Shared resources and IAM configurations
- **EC2 Module**: Instance and security group management
- **S3 Module**: Storage bucket with security features
- **VPC Module**: Network infrastructure and routing

## Environment Specifications

### Development (dev)
- Resource Sizing: t2.micro instances
- Network: 10.0.0.0/16 CIDR
- Purpose: Feature development and testing
- Minimal resource allocation
- More permissive security

### Staging
- Resource Sizing: t2.small instances
- Network: 10.1.0.0/16 CIDR
- Purpose: Pre-production testing
- Production-like configuration
- Similar security to production

### Production (prod)
- Resource Sizing: t2.medium instances
- Network: 10.2.0.0/16 CIDR
- Purpose: Live workloads
- Maximum resource allocation
- Strict security measures
- Remote state management

## Key Features

### 1. Infrastructure Components
- VPC with public/private subnets
- EC2 instances for web and application servers
- S3 buckets for storage
- IAM roles and policies

### 2. Security Measures
- Network isolation
- Security groups
- IAM role-based access
- Encryption at rest
- Public access blocking

### 3. Scalability
- Environment-specific sizing
- Expandable CIDR ranges
- Modular design
- Resource customization

## Deployment Workflow

### 1. Initial Setup
```bash
cd environments/<env>
terraform init
```

### 2. Configuration Review
```bash
terraform plan
```

### 3. Resource Creation
```bash
terraform apply
```

### 4. Resource Destruction
```bash
terraform destroy
```

### 5. Resource Destruction auto approve

**NOTE**: Resource Destruction Auto-Approve is NOT recommended in production environments.

```bash
terraform destroy --auto-approve
```

### 6. Specific resource Resource Destruction 
We do this using the **-target** flag provided by resource type and name of the resource.
```bash
terraform destroy -target=RESOURCE_TYPE.RESOURCE_NAME
```

### 7. Environment Management
- Independent state files
- Separate variable sets
- Environment-specific tags

## Best Practices Implemented

### 1. Code Organization
- Modular structure
- DRY (Don't Repeat Yourself) principles
- Clear separation of concerns
- Environment isolation

### 2. Security
- Least privilege principle
- Network segmentation
- Resource isolation
- Access controls
- Encryption

### 3. Maintainability
- Consistent naming
- Clear documentation
- Version control
- State management

## Resource Management

### 1. State Files
- Environment separation
- Remote backend (prod)
- State locking
- Backup management

### 2. Variables
- Environment-specific values
- Consistent naming
- Clear documentation
- Default values

### 3. Outputs
- Resource identifiers
- Network information
- Access details
