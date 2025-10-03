# =============================================================================
# Terraform Backend Configuration for Development Environment
# =============================================================================
# This configuration stores Terraform state in AWS S3 with DynamoDB locking
# for safe concurrent operations and state management

# terraform {
#   backend "s3" {
#     # S3 bucket for storing Terraform state
#     # Note: This bucket should be created manually before running terraform init
#     bucket = "suraj-terraform-state"
    
#     # State file path within the bucket
#     # Using environment-specific paths to avoid conflicts
#     key = "dev/terraform.tfstate"
    
#     # AWS region where the S3 bucket is located
#     region = "us-east-1"
    
#     # Enable server-side encryption for state file security
#     encrypt = true
    
#     # DynamoDB table for state locking (prevents concurrent modifications)
#     # Note: This table should be created manually with LockID as the primary key
#     dynamodb_table = "terraform-state-lock"
    
#     # Enable state locking to prevent concurrent operations
#     # This helps avoid state corruption when multiple users run terraform
#   }
# }

# =============================================================================
# Backend Configuration Setup Instructions:
# =============================================================================
# 1. Create S3 bucket manually:
#    aws s3 mb s3://suraj-terraform-state --region us-east-1
#    aws s3api put-bucket-versioning --bucket suraj-terraform-state --versioning-configuration Status=Enabled
#    aws s3api put-bucket-encryption --bucket suraj-terraform-state --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
#
# 2. Create DynamoDB table for locking:
#    aws dynamodb create-table --table-name terraform-state-lock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region us-east-1
#
# 3. Ensure your AWS credentials have appropriate permissions for S3 and DynamoDB operations
