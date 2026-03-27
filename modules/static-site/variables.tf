variable "bucket_name" {
  description = "S3 bucket name (must be globally unique)"
  type        = string
}

variable "domain_name" {
  description = "Custom domain (e.g., example.com). Leave empty for CloudFront URL only."
  type        = string
  default     = ""
}

variable "subject_alternative_names" {
  description = "Additional domains (e.g., www.example.com)"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID for DNS records"
  type        = string
  default     = ""
}

variable "auto_validate_cert" {
  description = "Auto-validate ACM certificate via Route53"
  type        = bool
  default     = true
}

variable "index_document" {
  description = "Default root object"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Custom error page (non-SPA)"
  type        = string
  default     = ""
}

variable "is_spa" {
  description = "Single Page Application — route 403/404 to index.html"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100" # US, Canada, Europe only (cheapest)
}

variable "default_ttl" {
  description = "Default cache TTL in seconds"
  type        = number
  default     = 86400 # 1 day
}

variable "max_ttl" {
  description = "Max cache TTL in seconds"
  type        = number
  default     = 31536000 # 1 year
}

variable "wait_for_deployment" {
  description = "Wait for CloudFront deployment to complete"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default     = {}
}
