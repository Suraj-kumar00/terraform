resource "aws_key_pair" "myapp_key" {
  key_name   = "${var.project_name}-${var.environment}-key"
  public_key = file(var.public_key_path)

  tags = {
    Name        = "${var.project_name}-${var.environment}-key"
    Environment = var.environment
  }
}
