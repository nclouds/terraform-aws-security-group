# Create a VPC
module "vpc" {
  count        = var.create_vpc ? 1 : 0
  source       = "git@github.com:nclouds/terraform-aws-vpc.git?ref=v0.1.0"
  multi_nat_gw = false
  vpc_settings = {
    application_subnets = ["10.10.16.0/22", "10.10.20.0/22"]
    public_subnets      = ["10.10.0.0/22", "10.10.4.0/22"]
    dns_hostnames       = true
    data_subnets        = []
    dns_support         = true
    tenancy             = "default"
    cidr                = "10.10.0.0/16"
  }
  identifier = "${var.identifier}_vpc"
  region     = "us-east-1"
  tags = {
    Owner = "sysops"
    env   = "dev"
  }
}

# Create a Security Group
module "security_group" {
  source     = "../.."
  identifier = "${var.identifier}-sg"
  vpc_id     = var.create_vpc ? module.vpc[0].output.vpc.id : "vpc-000fe2b5ddba6bb64"
  tags       = var.tags
}