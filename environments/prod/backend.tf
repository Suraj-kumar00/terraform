terraform {
  backend "s3" {
    bucket      = "suraj-infar360-terraform-state"
    key         = "prod/terraform.tfstate"
    region      = "us-east-1"
    encrypt     = true
    use_lockfile = true  # This is enable S3 state locking
  }
}
