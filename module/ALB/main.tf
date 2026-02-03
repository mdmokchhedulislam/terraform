resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.deletion_protection

  access_logs {
    bucket  = var.log_bucket
    prefix  = var.log_prefix
    enabled = true
  }

  tags = var.tags
}
