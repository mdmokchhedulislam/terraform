provider "aws" {
  region = var.regivalue
}

resource "aws_instance" "test_instance" {
  ami           = var.amivalue
  instance_type = var.instance_type

  tags = var.commontags
}