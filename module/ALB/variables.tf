variable "name" {
  type        = string
}

variable "internal" {
  type        = bool
  default     = false
}

variable "security_groups" {
  type        = list(string)
}

variable "subnets" {
  type        = list(string)
}

variable "deletion_protection" {
  type        = bool
  default     = false
}

variable "log_bucket" {
  type        = string
}

variable "log_prefix" {
  type        = string
  default     = "alb-logs"
}

variable "tags" {
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "my-app"
  }
}