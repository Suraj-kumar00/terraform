module "ecr" {
  source = "../../modules/ecr"
  aws_region = var.aws_region
  microservices = [
    "frontend",
    "backend"
  ]
  
  name_suffix           = "-suraj"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  max_image_count      = 3
  untagged_image_days  = 1
  
  common_tags = {
    Environment = "dev"
    Project     = "microservices"
  }
}
