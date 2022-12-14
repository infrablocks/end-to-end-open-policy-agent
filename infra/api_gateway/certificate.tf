module "certificate" {
  source  = "infrablocks/acm-certificate/aws"
  version = "1.2.0-rc.1"

  domain_name = var.domain_name
  domain_zone_id = var.hosted_zone_id

  subject_alternative_names = []
  subject_alternative_name_zone_id = var.hosted_zone_id

  providers = {
    aws.certificate = aws.us_east_1
    aws.domain_validation = aws.us_east_1
    aws.san_validation = aws.us_east_1
  }
}
