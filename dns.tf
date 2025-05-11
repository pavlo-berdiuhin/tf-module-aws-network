################################################################################
# Route53 zones
################################################################################
resource "aws_route53_zone" "public" {
  for_each = toset([for domain, cfg in var.dns_domain_configs : domain if cfg.public_zone])

  name = each.key
}


resource "aws_route53_zone" "private" {
  for_each = toset([for domain, cfg in var.dns_domain_configs : domain if cfg.private_zone])

  name = each.key
  vpc {
    vpc_id = module.vpc.vpc_id
  }
  lifecycle {
    ignore_changes = [vpc]
  }
}

################################################################################
# ACM Certificates and Validations
################################################################################
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"

  for_each = toset([for domain, cfg in var.dns_domain_configs : domain if cfg.create_certificate])

  domain_name = each.key
  zone_id     = aws_route53_zone.public[each.key].zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${each.key}",
    "*.int.${each.key}",
    "*.dev.${each.key}",
    "*.stage.${each.key}",
  ]

  wait_for_validation = true

  tags = {
    Name = each.key
  }
}
