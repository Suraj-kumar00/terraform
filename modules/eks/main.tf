# EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = concat(var.public_subnet_ids, var.private_subnet_ids)
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  enabled_cluster_log_types = var.cluster_log_types

  # encryption_config {
  #   provider {
  #     key_arn = var.kms_key_arn
  #   }
  #   resources = ["secrets"]
  # }
  dynamic "encryption_config" {
  for_each = var.kms_key_arn != null ? [1] : []  
  content {
    provider {
      key_arn = var.kms_key_arn
    }
    resources = ["secrets"]
  }
}

  depends_on = [
    var.cluster_policy_attachment,
  ]

  tags = var.tags
}

# EKS Node Group
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  capacity_type  = var.capacity_type
  instance_types = var.instance_types
  ami_type       = var.ami_type
  disk_size      = var.disk_size

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  depends_on = [
    var.node_policy_attachments,
  ]

  tags = var.tags
}

# Security Group for additional EKS rules
resource "aws_security_group" "eks_additional" {
  name_prefix = "${var.cluster_name}-eks-additional"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-eks-additional-sg"
  })
}
