# SSH Key Pair
# module "keypair" {
#   source = "../../modules/keypair"

#   project_name    = var.project_name
#   environment     = var.environment
#   public_key_path = var.public_key_path
# }

# Common resources
# module "common" {
#   source = "../../modules/common"

#   project_name  = var.project_name
#   environment   = var.environment
#   s3_bucket_arn = module.app_bucket.bucket_arn
#   aws_region    = var.aws_region
# }

# VPC Module
# module "vpc" {
#   source = "../../modules/vpc"

#   vpc_cidr     = var.vpc_cidr
#   environment  = var.environment
#   project_name = var.project_name
# }


# Web Server - Production uses auto scaling group
# module "web_server" {
#   source = "../../modules/ec2"

#   instance_name         = "${var.project_name}-${var.environment}-web"
#   instance_type        = var.web_instance_type
#   subnet_id           = module.vpc.public_subnet_id
#   vpc_id              = module.vpc.vpc_id
#   key_name            = module.keypair.key_name
#   environment         = var.environment
# }

# App Server - Production uses auto scaling group
# module "app_server" {
#   source = "../../modules/ec2"

#   instance_name         = "${var.project_name}-${var.environment}-app"
#   instance_type        = var.app_instance_type
#   subnet_id           = module.vpc.private_subnet_id
#   vpc_id              = module.vpc.vpc_id
#   key_name            = module.keypair.key_name
#   environment         = var.environment
# }

# S3 Bucket with versioning enabled
# module "app_bucket" {
#   source = "../../modules/s3"

#   bucket_name       = "${var.project_name}-${var.environment}-bucket-${random_string.suffix.result}"
#   environment       = var.environment
#   enable_versioning = true
# }

# EKS Cluster
# module "eks" {
#   source = "../../modules/eks"

#   project_name    = var.project_name
#   environment     = var.environment
#   vpc_id         = module.vpc.vpc_id
#   subnet_ids     = [module.vpc.private_subnet_id, module.vpc.public_subnet_id]
  
#   kubernetes_version  = "1.30"
#   desired_size       = 2
#   min_size          = 1
#   max_size          = 4
#   spot_instance_types = ["t3.medium", "t3.large", "t2.medium"]
# }

# AWS ECR for Building and Storing Docker Images

module "ecr" {
  source = "../../modules/ecr"
  aws_region = var.aws_region
  microservices = [
    "shippingservice",
    "quoteservice", 
    "recommendationservice",
    "productcatalogservice",
    "paymentservice",
    "loadgenerator",
    "kafka",
    "frontendproxy",
    "frauddetectionservice",
    "featureflagservice",
    "emailservice",
    "checkoutservice",
    "cartservice",
    "adservice",
    "accountingservice"
  ]
  
  name_suffix           = "-suraj"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  max_image_count      = 3
  untagged_image_days  = 1
  
  common_tags = {
    Environment = "prod"
    Project     = "microservices"
    ManagedBy   = "terraform"
  }
}

# Random string for bucket name
# resource "random_string" "suffix" {
#   length  = 8
#   special = false
#   upper   = false
# }