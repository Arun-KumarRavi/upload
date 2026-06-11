# Create a VPC with CIDR block

resource "aws_vpc" "project-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    Environment = "deployment"
    terraform   = "true"
  }
}
