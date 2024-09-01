## Need to be added

You'll need to add your key to be used for ssh to the ec2 instance


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.59.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.4 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.Master_Node](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/instance) | resource |
| [aws_instance.Worker_Node](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/instance) | resource |
| [aws_key_pair.key](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/key_pair) | resource |
| [aws_security_group.network-security-group](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/security_group) | resource |
| [local_file.inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.ansible_runner](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Master-ami"></a> [Master-ami](#input\_Master-ami) | n/a | `any` | n/a | yes |
| <a name="input_Master-instance-type"></a> [Master-instance-type](#input\_Master-instance-type) | n/a | `any` | n/a | yes |
| <a name="input_key-name"></a> [key-name](#input\_key-name) | n/a | `any` | n/a | yes |
| <a name="input_network-security-group-name"></a> [network-security-group-name](#input\_network-security-group-name) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_Master_ip"></a> [ec2\_Master\_ip](#output\_ec2\_Master\_ip) | n/a |
| <a name="output_ec2_Worker_ip"></a> [ec2\_Worker\_ip](#output\_ec2\_Worker\_ip) | n/a |
| <a name="output_ec2_public_ip"></a> [ec2\_public\_ip](#output\_ec2\_public\_ip) | n/a |
<!-- END_TF_DOCS -->
