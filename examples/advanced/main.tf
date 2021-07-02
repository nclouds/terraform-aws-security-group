# Create a VPC
module "vpc" {
  count        = var.create_vpc ? 1 : 0
  source       = "app.terraform.io/ncodelibrary/vpc/aws"
  version      = "0.1.3"
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
  identifier = var.identifier
  region     = "us-east-1"
  tags       = var.tags
}

# Create a Security Group
module "security_group" {
  source     = "../.."
  identifier = "${var.identifier}-sg"
  vpc_id     = var.create_vpc ? module.vpc[0].output.vpc.id : "vpc-000fe2b5ddba6bb64"
  ingress_rule_list = [
    {
      cidr_blocks = ["0.0.0.0/0"],
      description = "HTTPS inbound",
      from_port   = 443,
      protocol    = "tcp",
      to_port     = 443
    },
    {
      cidr_blocks = ["0.0.0.0/0"],
      description = "HTTP inbound",
      from_port   = 80,
      protocol    = "tcp",
      to_port     = 80
  }]
  egress_rule_list = [{
    cidr_blocks = ["0.0.0.0/0"],
    description = "HTTPS outbound",
    from_port   = 443,
    protocol    = "tcp",
    to_port     = 443
    },
    {
      cidr_blocks = ["0.0.0.0/0"],
      description = "HTTP outbound",
      from_port   = 80,
      protocol    = "tcp",
      to_port     = 80
    }
  ]
  tags = var.tags
}