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

output "database_subnets_ids" {
  value       = module.vpc.database_subnets
  description = "VPC database subnets IDs"
}