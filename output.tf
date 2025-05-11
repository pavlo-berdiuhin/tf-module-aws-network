output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnets_ids" {
  value       = module.vpc.public_subnets
  description = "VPC public subnets IDs"
}

output "private_subnets_ids" {
  value       = module.vpc.private_subnets
  description = "VPC private subnets IDs"
}

output "intra_subnets_ids" {
  value       = module.vpc.intra_subnets
  description = "VPC intra subnets IDs"
}

output "database_subnets_ids" {
  value       = module.vpc.database_subnets
  description = "VPC database subnets IDs"
}

output "dns_domain_configs" {
  description = "Map of domain names to their Route53 zone IDs and ACM certificate ARNs"
  value = {
    for domain, cfg in var.dns_domain_configs : domain => {
      private_zone_id = cfg.private_zone ? aws_route53_zone.private[domain].zone_id : null
      public_zone_id  = cfg.public_zone ? aws_route53_zone.public[domain].zone_id : null
      certificate     = cfg.create_certificate ? module.acm[domain].acm_certificate_arn : null
    }
  }
}