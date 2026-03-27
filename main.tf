module "static_site" {
  source = "./modules/static-site"

  bucket_name               = var.bucket_name
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  route53_zone_id           = var.route53_zone_id
  index_document            = var.index_document
  error_document            = var.error_document
  is_spa                    = var.is_spa
  enable_versioning         = var.enable_versioning
  price_class               = var.price_class

  tags = var.tags

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
