resource "aws_ecr_repository" "microservices" {
  for_each = toset(var.microservices)
  
  name                 = "${each.value}${var.name_suffix}"
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(var.common_tags, {
    Name        = each.value
    ServiceType = "microservice"
  })
}

# Get ECR login token
data "aws_ecr_authorization_token" "token" {}

# Build and push images
resource "null_resource" "build_and_push" {
  for_each = aws_ecr_repository.microservices

  triggers = {
    repository_url = each.value.repository_url
    # Add file hash to trigger rebuild when Dockerfile changes
    dockerfile_hash = filemd5("${path.root}/../../../microservice/${each.key}/Dockerfile")

  }

  provisioner "local-exec" {
    command = <<-EOT
      # Login to ECR
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${each.value.repository_url}
      
      # Build image
      docker build -t ${each.key}:latest -f ${path.root}/../../../microservice/${each.key}/Dockerfile ${path.root}/../../../microservice/${each.key}
      
      # Tag image
      docker tag ${each.key}:latest ${each.value.repository_url}:latest
      
      # Push image
      docker push ${each.value.repository_url}:latest
    EOT
  }

  depends_on = [aws_ecr_repository.microservices]
}


resource "aws_ecr_lifecycle_policy" "microservices" {
  for_each = aws_ecr_repository.microservices

  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Delete untagged images older than ${var.untagged_image_days} days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.untagged_image_days
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep last ${var.max_image_count} images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}