provider "aws" {
  region = var.aws_region
  default_tags {
    tags = merge({
      terraform   = "true"
      owner       = var.owner
      environment = var.environment
      stack       = var.stack
      team        = var.team
    }, var.additional_tags)
  }
}


data "aws_availability_zones" "this" {}


locals {
  azs               = slice(data.aws_availability_zones.this.names, 0, 3)
  deployment_prefix = "${var.environment}-${var.stack}"
}

################################################################################
# VPC
################################################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"
  name    = "${local.deployment_prefix}-vpc"
  cidr    = var.cidr
  azs     = local.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  intra_subnets   = var.intra_subnets

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "${local.deployment_prefix}-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${local.deployment_prefix}-default" }

  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.deployment_prefix}-default" }

  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnet_tags  = var.additional_public_subnet_tags
  private_subnet_tags = var.additional_private_subnet_tags
  intra_subnet_tags   = var.additional_intra_subnet_tags
}

################################################################################
# VPC Endpoints Module
################################################################################
module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.21.0"

  vpc_id = module.vpc.vpc_id

  create_security_group      = true
  security_group_name_prefix = "${local.deployment_prefix}-vpc-endpoints-"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  endpoints = merge({
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      tags            = { Name = "${local.deployment_prefix}-s3" }
    },
    dynamodb = {
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      policy          = data.aws_iam_policy_document.generic_endpoint_policy.json
      tags            = { Name = "${local.deployment_prefix}-dynamodb" }
    },
  }, var.additional_vpc_endpoints)
}


data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}
