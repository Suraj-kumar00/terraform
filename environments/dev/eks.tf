module "eks" {
  source = "../../modules/eks"

  cluster_name      = var.cluster_name
  cluster_role_arn  = module.iam.cluster_role_arn
  node_role_arn     = module.iam.node_role_arn
  
  vpc_id            = module.vpc.vpc_id
  vpc_cidr_block    = module.vpc.vpc_cidr_block
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  
  kubernetes_version = var.kubernetes_version
  instance_types     = var.instance_types
  desired_size       = var.desired_size
  max_size          = var.max_size
  min_size          = var.min_size
  
  # Dependencies
  cluster_policy_attachment = module.iam
  node_policy_attachments   = [module.iam]
  
  tags = {
    Environment = var.environment
    Project     = "EKS-Custom-Cluster"
  }
}