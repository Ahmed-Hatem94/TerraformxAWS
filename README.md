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
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.5 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Jenkins_instance"></a> [Jenkins\_instance](#module\_Jenkins\_instance) | ./modules/ec2_instance | n/a |
| <a name="module_master_instance"></a> [master\_instance](#module\_master\_instance) | ./modules/ec2_instance | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security_group | n/a |
| <a name="module_worker_instance"></a> [worker\_instance](#module\_worker\_instance) | ./modules/ec2_instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.key](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/key_pair) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/vpc) | resource |
| [local_file.inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.priv_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.ansible_runner](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.priv_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.latest_amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/data-sources/ami) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Jenkins-instance-type"></a> [Jenkins-instance-type](#input\_Jenkins-instance-type) | AWS instance type for the Jenkins node, the defualt will be t2.medium as it's the least for the kubernetes | `string` | `"t2.micro"` | no |
| <a name="input_Jenkins_root_block_device"></a> [Jenkins\_root\_block\_device](#input\_Jenkins\_root\_block\_device) | The root block device configuration for the Jenkins instance | <pre>object({<br/>    volume_type           = string<br/>    volume_size           = number<br/>    delete_on_termination = bool<br/>  })</pre> | <pre>{<br/>  "delete_on_termination": true,<br/>  "volume_size": 8,<br/>  "volume_type": "gp3"<br/>}</pre> | no |
| <a name="input_Master-instance-type"></a> [Master-instance-type](#input\_Master-instance-type) | AWS instance type for the master node, the defualt will be t2.medium as it's the least for the kubernetes | `string` | `"t2.medium"` | no |
| <a name="input_Worker-count"></a> [Worker-count](#input\_Worker-count) | Worker nodes count to be deployed | `number` | `2` | no |
| <a name="input_Worker-instance-type"></a> [Worker-instance-type](#input\_Worker-instance-type) | AWS instance type for the Worker node, the defualt will be t2.medium as it's the least for the kubernetes | `string` | `"t2.medium"` | no |
| <a name="input_key-name"></a> [key-name](#input\_key-name) | Your SSH-Key name | `string` | `"my-key"` | no |
| <a name="input_master_root_block_device"></a> [master\_root\_block\_device](#input\_master\_root\_block\_device) | The root block device configuration for the master instance | <pre>object({<br/>    volume_type           = string<br/>    volume_size           = number<br/>    delete_on_termination = bool<br/>  })</pre> | <pre>{<br/>  "delete_on_termination": true,<br/>  "volume_size": 8,<br/>  "volume_type": "gp3"<br/>}</pre> | no |
| <a name="input_network-security-group-name"></a> [network-security-group-name](#input\_network-security-group-name) | Your Network security group name | `string` | `"nsg-inbound"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy resources | `string` | `"us-east-1"` | no |
| <a name="input_worker_root_block_device"></a> [worker\_root\_block\_device](#input\_worker\_root\_block\_device) | The root block device configuration for the worker instances | <pre>object({<br/>    volume_type           = string<br/>    volume_size           = number<br/>    delete_on_termination = bool<br/>  })</pre> | <pre>{<br/>  "delete_on_termination": true,<br/>  "volume_size": 8,<br/>  "volume_type": "gp3"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_Jenkins_ip"></a> [ec2\_Jenkins\_ip](#output\_ec2\_Jenkins\_ip) | All your worker nodes IPs |
| <a name="output_ec2_Master_ip"></a> [ec2\_Master\_ip](#output\_ec2\_Master\_ip) | Your Control-plane IP |
| <a name="output_ec2_Worker_ip"></a> [ec2\_Worker\_ip](#output\_ec2\_Worker\_ip) | All your worker nodes IPs |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_your_public_ip"></a> [your\_public\_ip](#output\_your\_public\_ip) | Your current public IP |
<!-- END_TF_DOCS -->