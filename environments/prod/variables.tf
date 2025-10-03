variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "microservices" {
  description = "List of microservice names"
  type        = list(string)
}


variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "web_instance_type" {
  description = "Instance type for web server"
  type        = string
}

variable "app_instance_type" {
  description = "Instance type for application server"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key file"
  type        = string
  default     = "~/.ssh/myapp_key.pub"
}