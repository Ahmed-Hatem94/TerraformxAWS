## Usage

This Project is using terraform to deploy on AWS, an EC2 (1 control-plane and X number of worker nodes) which is then handled by ansible to install kubernetes and preparing the cluster to be ready

## Working with project

you'll need to run the starting script "[projectSetup.sh](projectSetup.sh)" by the following way

```#!/bin/sh
. projectSetup.sh
```

or

```#!/bin/sh
source projectSetup.sh
```
> [!NOTE]  
> the script needs to run by this way to be able to export AWS credentials as env variables

after this you can start using the project by terraform plan  or terraform apply 



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
| <a name="input_Master-ami"></a> [Master-ami](#input\_Master-ami) | AWS ami used for master instance, you can updated to the latest ami | `string` | `"ami-00f251754ac5da7f0"` | no |
| <a name="input_Master-instance-type"></a> [Master-instance-type](#input\_Master-instance-type) | AWS instance type for the master node, the defualt will be t2.medium as it's the least for the kubernetes | `string` | `"t2.medium"` | no |
| <a name="input_Worker-ami"></a> [Worker-ami](#input\_Worker-ami) | AWS ami used for Worker instance, you can updated to the latest ami | `string` | `"ami-00f251754ac5da7f0"` | no |
| <a name="input_Worker-count"></a> [Worker-count](#input\_Worker-count) | Worker nodes count to be deployed | `number` | `"1"` | no |
| <a name="input_Worker-instance-type"></a> [Worker-instance-type](#input\_Worker-instance-type) | AWS instance type for the master node, the defualt will be t2.medium as it's the least for the kubernetes | `string` | `"t2.medium"` | no |
| <a name="input_key-name"></a> [key-name](#input\_key-name) | Your SSH-Key name | `string` | `"my-key"` | no |
| <a name="input_network-security-group-name"></a> [network-security-group-name](#input\_network-security-group-name) | Your Network security group name | `string` | `"nsg-inbound"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_Master_ip"></a> [ec2\_Master\_ip](#output\_ec2\_Master\_ip) | Your Control-plane ip |
| <a name="output_ec2_Worker_ip"></a> [ec2\_Worker\_ip](#output\_ec2\_Worker\_ip) | All your worker nodes ips |
| <a name="output_your_public_ip"></a> [your\_public\_ip](#output\_your\_public\_ip) | Your current public ip |
<!-- END_TF_DOCS -->
