[SourceCode](https://github.com/nclouds/terraform-aws-security-group/tree/v0.2.3/examples/simple)   
[Report an Issue](https://github.com/nclouds/terraform-aws-security-group/issues)

# Simple Security Group example

Configuration in this directory creates the following.
- Security Group with default rules

You can choose to create a Security Group with the following options:

- Create a Security Group in an existing VPC:
    ```
        create_vpc = false          # Default setup
    ```
- Create an Security Group in a new VPC: 
    This creates a new VPC in your account and then provisions Security Group inside that VPC.
    ```
        create_vpc = true
    ```

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.
