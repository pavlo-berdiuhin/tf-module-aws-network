variable "aws_region" {
  type        = string
  description = "AWS Region were stack will be deployed"
}

variable "environment" {
  type        = string
  description = "Environment name e.g. dev, staging, prod, etc."
}

variable "stack" {
  type        = string
  description = "Stack name e.g. frontend, data, etc."
}

variable "owner" {
  type        = string
  description = "Company owner of the resources"
}

variable "team" {
  type        = string
  description = "Team name"
  default     = "devops"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags for all resources"
  default     = {}
}

variable "cidr" {
  type        = string
  description = "VPC CIDR range"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets CIDRs"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets CIDRs"
}

variable "intra_subnets" {
  type        = list(string)
  description = "List of intra subnets CIDRs"
  default     = []
}

variable "additional_public_subnet_tags" {
  type        = map(string)
  description = "Additional tags for public subnets"
  default     = {}
}

variable "additional_private_subnet_tags" {
  type        = map(string)
  description = "Additional tags for private subnets"
  default     = {}
}

variable "additional_intra_subnet_tags" {
  type        = map(string)
  description = "Additional tags for intra subnets"
  default     = {}
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
  default     = true
}

variable "dns_domain_configs" {
  description = "Route53 dns_zones"
  type = map(object({
    private_zone       = optional(bool, true)
    public_zone        = optional(bool, false)
    create_certificate = optional(bool, false)
  }))
  default = {}
}
