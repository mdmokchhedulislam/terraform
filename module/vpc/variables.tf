variable "public_subnet_map" {
  type = map(object({
    cidr = string
    az   = string
  }))
}