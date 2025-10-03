# Common resources
module "common" {
  source = "../../modules/common"

  project_name  = var.project_name
  environment   = var.environment
  s3_bucket_arn = module.app_bucket.bucket_arn
  aws_region    = var.aws_region
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
  project_name = var.project_name
}

# Web Server
module "web_server" {
  source = "../../modules/ec2"

  instance_name         = "${var.project_name}-${var.environment}-web"
  instance_type        = var.web_instance_type
  subnet_id           = module.vpc.public_subnet_id
  vpc_id              = module.vpc.vpc_id
  key_name            = var.key_name
  environment         = var.environment
}

# App Server
module "app_server" {
  source = "../../modules/ec2"

  instance_name         = "${var.project_name}-${var.environment}-app"
  instance_type        = var.app_instance_type
  subnet_id           = module.vpc.private_subnet_id
  vpc_id              = module.vpc.vpc_id
  key_name            = var.key_name
  environment         = var.environment
}

# S3 Bucket
module "app_bucket" {
  source = "../../modules/s3"

  bucket_name       = "${var.project_name}-${var.environment}-bucket-${random_string.suffix.result}"
  environment       = var.environment
  enable_versioning = true
}

# Random string for bucket name
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}