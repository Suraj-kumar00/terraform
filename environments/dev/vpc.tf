module "vpc" {
  source = "../../modules/vpc"

  cluster_name         = var.cluster_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  
  tags = {
    Environment = var.environment
    Project     = "EKS-Custom"
    ManagedBy   = "Terraform"
  }
}