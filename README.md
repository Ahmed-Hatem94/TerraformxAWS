
## Working with the Dockerfile

add your AWS credentials to the .env file as below:


```#!/bin/sh
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION==
```

then run the build command using the following syntax:

`cat .env | xargs printf -- '--build-arg %s\n' | xargs docker build -t readyenv .`

then run the image by

`docker run -it readyenv /bin/bash`

## Ansible Version

Ansible core 2.16.0 is required to support the yum module.

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
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

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
| [local_file.priv_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.ansible_runner](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.priv_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Master-ami"></a> [Master-ami](#input\_Master-ami) | n/a | `any` | n/a | yes |
| <a name="input_Master-instance-type"></a> [Master-instance-type](#input\_Master-instance-type) | n/a | `any` | n/a | yes |
| <a name="input_Worker-ami"></a> [Worker-ami](#input\_Worker-ami) | n/a | `any` | n/a | yes |
| <a name="input_Worker-count"></a> [Worker-count](#input\_Worker-count) | n/a | `number` | `"1"` | no |
| <a name="input_Worker-instance-type"></a> [Worker-instance-type](#input\_Worker-instance-type) | n/a | `any` | n/a | yes |
| <a name="input_key-name"></a> [key-name](#input\_key-name) | n/a | `any` | n/a | yes |
| <a name="input_network-security-group-name"></a> [network-security-group-name](#input\_network-security-group-name) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_Master_ip"></a> [ec2\_Master\_ip](#output\_ec2\_Master\_ip) | n/a |
| <a name="output_ec2_Worker_ip"></a> [ec2\_Worker\_ip](#output\_ec2\_Worker\_ip) | n/a |
| <a name="output_your_public_ip"></a> [your\_public\_ip](#output\_your\_public\_ip) | n/a |
<!-- END_TF_DOCS -->
