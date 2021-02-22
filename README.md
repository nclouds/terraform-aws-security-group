# AWS Security Group (SG) Terraform Module

Terraform module to provision [`AWS VPC Security Group`](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) on AWS.

## Usage

### Simple setup

Create a simple security group with default rules.
```hcl
    module "security_group" {
        source     = "git@github.com:nclouds/terraform-aws-security-group.git?ref=v0.1.1"
        identifier = "example-sg"
        vpc_id     = "vpc-xxxxxxxxxxxxx"
        tags       = {
            Owner       = "sysops"
            env         = "dev"
            Cost_Center = "XYZ"
        }
    }
```

For more details on a working example, please visit [`examples/simple`](examples/simple)

### Advanced Setup
If you want to create security group with custom rules, you can use the module like this:

```hcl
    module "security_group" {
        source     = "git@github.com:nclouds/terraform-aws-security-group.git?ref=v0.1.1"
        identifier = "example-sg"
        vpc_id     = "vpc-xxxxxxxxxxxxx"
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
```

For more options refer to a working example at [`examples/advanced`](examples/advanced)

## Examples
Here are some working examples of using this module:
- [`examples/simple`](examples/simple)
- [`examples/advanced`](examples/advanced)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | A description for the security group | `string` | `"Security group created by terraform"` | no |
| egress\_rule\_list | List of security group egress rules | <pre>list(object({<br>    cidr_blocks = list(string),<br>    description = string,<br>    from_port   = number,<br>    protocol    = string,<br>    to_port     = number<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Default egress rule",<br>    "from_port": 0,<br>    "protocol": "all",<br>    "to_port": 65535<br>  }<br>]</pre> | no |
| identifier | The name of the security group | `string` | n/a | yes |
| ingress\_rule\_list | List of security group ingress rules | <pre>list(object({<br>    cidr_blocks = list(string),<br>    description = string,<br>    from_port   = number,<br>    protocol    = string,<br>    to_port     = number<br>  }))</pre> | `[]` | no |
| tags | Tags to be applied to the resource | `map` | `{}` | no |
| vpc\_id | The id of the VPC where the security group is being deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| output | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing
If you want to contribute to this repository check all the guidelines specified [here](.github/CONTRIBUTING.md) before submitting a new PR.
