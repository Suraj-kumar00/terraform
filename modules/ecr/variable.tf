variable "microservices" {
  description = "List of microservice names"
  type        = list(string)
}

variable "name_suffix" {
  description = "Suffix to append to repository names"
  type        = string
  default     = ""
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = string
  default     = "MUTABLE"
}

variable "force_delete" {
  description = "If true, will delete the repository even if it contains images"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "The encryption type to use for the repository"
  type        = string
  default     = "AES256"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed"
  type        = bool
  default     = true
}

variable "max_image_count" {
  description = "Maximum number of images to keep"
  type        = number
  default     = 10
}

variable "untagged_image_days" {
  description = "Number of days to keep untagged images"
  type        = number
  default     = 7
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}



variable "dockerfile_paths" {
  description = "Map of microservice names to their Dockerfile paths"
  type        = map(string)
  default     = {}
}

variable "build_contexts" {
  description = "Map of microservice names to their build context paths"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "AWS region for ECR login"
  type        = string
}

variable "enable_build_push" {
  description = "Enable building and pushing Docker images"
  type        = bool
  default     = false
}
