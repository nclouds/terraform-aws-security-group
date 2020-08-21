# terraform-aws-security-group

Terraform Module to create an AWS Security Group.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

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
