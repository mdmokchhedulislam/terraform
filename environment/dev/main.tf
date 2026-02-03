

module "alb_sg" {
  source         = "../../module/security"
  sg_name        = "my-alb-security-group"
  sg_description = "Allow HTTP/HTTPS for ALB"
  vpc_id         = module.vpc.vpc_id

  ingress_rules = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
  tags = var.tags
}


module "my_vpc" {
  source       = "../../module/vpc"
  project_name = "dev_vpc"
  vpc_cidr     = "10.0.0.0/16"

 
  public_subnet_map = {
    "web-1" = { cidr = "10.0.1.0/24", az = "us-east-1a" }
    "web-2" = { cidr = "10.0.2.0/24", az = "us-east-1b" }
  }
  
  tags = { Environment = "dev" }
}


module "alb" {
  source = "../../module/ALB"

  name                = "prod-alb"
  internal            = false
  security_groups     = module.security.sg_id
  subnets             = module.vpc.public_subnet_ids
  deletion_protection = true
  log_bucket          = aws_s3_bucket.lb_logs.id
  log_prefix          = "alb"

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}


