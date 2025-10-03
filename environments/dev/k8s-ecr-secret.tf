# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }

# data "aws_eks_cluster" "cluster" {
#   name = var.cluster_name
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = var.cluster_name
# }

# resource "kubernetes_secret" "regcred" {
#   metadata {
#     name = "regcred"
#   }

#   type = "kubernetes.io/dockerconfigjson"

#   data = {
#     ".dockerconfigjson" = jsonencode({
#       auths = {
#         "${local.ecr_endpoint}" = {
#           "username" = "AWS"
#           "password" = data.aws_ecr_authorization_token.token.password
#           "email"    = "none"
#           "auth"     = base64encode("AWS:${data.aws_ecr_authorization_token.token.password}")
#         }
#       }
#     })
#   }
# }

# data "aws_ecr_authorization_token" "token" {
# }

# locals {
#   ecr_endpoint = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
# }

# data "aws_caller_identity" "current" {} 