

module "alb_sg" {
  source         = "../../module/security"
  sg_name        = "my-alb-security-group"
  sg_description = "Allow HTTP/HTTPS for ALB"
  vpc_id         = var.vpc_id

  ingress_rules = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
  tags = var.tags
}


module "alb" {
  source = "../../module/ALB"

  name                = "prod-alb"
  internal            = false
  security_groups     = [aws_security_group.lb_sg.id]
  subnets             = [for s in aws_subnet.public : s.id]
  deletion_protection = true
  log_bucket          = aws_s3_bucket.lb_logs.id
  log_prefix          = "alb"

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}


