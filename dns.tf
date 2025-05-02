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
resource "aws_acm_certificate" "this" {
  for_each = toset([for domain, cfg in var.dns_domain_configs : domain if cfg.create_certificate])

  domain_name       = "*.${each.key}"
  validation_method = "DNS"

  depends_on = [
    aws_route53_zone.public,
    aws_route53_zone.private
  ]
}


resource "aws_route53_record" "cert_validation" {
  for_each = toset([for domain, cfg in var.dns_domain_configs : domain if cfg.create_certificate])

  zone_id = aws_route53_zone.public[each.key].zone_id
  name    = tolist(aws_acm_certificate.this[each.key].domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.this[each.key].domain_validation_options)[0].resource_record_type
  records = [
    tolist(aws_acm_certificate.this[each.key].domain_validation_options)[0].resource_record_value
  ]
  ttl = 60

  depends_on = [aws_acm_certificate.this]
}


resource "aws_acm_certificate_validation" "this" {
  for_each = aws_acm_certificate.this

  certificate_arn = each.value.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation[each.key].fqdn
  ]
}