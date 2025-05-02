# tf-module-aws-network

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.97.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.21.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | 5.21.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.generic_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_intra_subnet_tags"></a> [additional\_intra\_subnet\_tags](#input\_additional\_intra\_subnet\_tags) | Additional tags for intra subnets | `map(string)` | `{}` | no |
| <a name="input_additional_private_subnet_tags"></a> [additional\_private\_subnet\_tags](#input\_additional\_private\_subnet\_tags) | Additional tags for private subnets | `map(string)` | `{}` | no |
| <a name="input_additional_public_subnet_tags"></a> [additional\_public\_subnet\_tags](#input\_additional\_public\_subnet\_tags) | Additional tags for public subnets | `map(string)` | `{}` | no |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region were stack will be deployed | `string` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | VPC CIDR range | `string` | n/a | yes |
| <a name="input_dns_domain_configs"></a> [dns\_domain\_configs](#input\_dns\_domain\_configs) | Route53 dns\_zones | <pre>map(object({<br/>    private_zone       = optional(bool, true)<br/>    public_zone        = optional(bool, false)<br/>    create_certificate = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable NAT gateway | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name e.g. dev, staging, prod, etc. | `string` | n/a | yes |
| <a name="input_intra_subnets"></a> [intra\_subnets](#input\_intra\_subnets) | List of intra subnets CIDRs | `list(string)` | `[]` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Company owner of the resources | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets CIDRs | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnets CIDRs | `list(string)` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Stack name e.g. frontend, data, etc. | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Team name | `string` | `"devops"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnets_ids"></a> [database\_subnets\_ids](#output\_database\_subnets\_ids) | VPC database subnets IDs |
| <a name="output_dns_domain_configs"></a> [dns\_domain\_configs](#output\_dns\_domain\_configs) | Map of domain names to their Route53 zone IDs and ACM certificate ARNs |
| <a name="output_intra_subnets_ids"></a> [intra\_subnets\_ids](#output\_intra\_subnets\_ids) | VPC intra subnets IDs |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | VPC private subnets IDs |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | VPC public subnets IDs |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
<!-- END_TF_DOCS -->
