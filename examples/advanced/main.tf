locals {
  policies = {
    logs = {
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      resources = [
        "*",
      ]
    }
  }
}

data "aws_iam_policy_document" "document" {
  statement {
    actions   = local.policies["logs"]["actions"]
    resources = local.policies["logs"]["resources"]
  }
}

module "iam_policy" {
  source = "git@github.com:nclouds/terraform-aws-iam-policy.git?ref=v0.1.7"

  rendered_policy = data.aws_iam_policy_document.document.json
  description     = "IAM Policy for VPC Flow Logs Cloudwatch"
  identifier      = "cw-flow-logs-access"
}

module "flow_logs_role" {
  source = "git@github.com:nclouds/terraform-aws-iam-role.git?ref=v0.2.5"

  iam_policies_to_attach = [
    module.iam_policy.output.policy.arn
  ]

  aws_service_principal = "vpc-flow-logs.amazonaws.com"
  description           = "Example IAM Role"
  identifier            = "${var.identifier}-flow-logs"
}

# Create a VPC
module "vpc" {
  source       = "git@github.com:nclouds/terraform-aws-vpc.git?ref=v0.3.0"
  multi_nat_gw = false
  flow_log_settings = {
    max_aggregation_interval = 600
    flow_log_destination_arn = null
    logs_retention_in_days   = 30
    log_destination_type     = "cloud-watch-logs"
    enable_flow_log          = true
    iam_role_arn             = module.flow_logs_role.output.role.arn
    traffic_type             = "ALL"
  }
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
}

# Create a Security Group
module "security_group" {
  source     = "../.."
  identifier = "${var.identifier}-sg"
  vpc_id     = module.vpc.output.vpc.id
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
}
