module "iam" {
  source = "../../modules/iam"

  cluster_name = var.cluster_name
  
  tags = {
    Environment = var.environment
    Project     = "EKS-Custom-iam"  
  }
}