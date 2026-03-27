# terraform-s3-cloudfront-site

Deploy a static website on AWS with S3 + CloudFront CDN in one `terraform apply`. Supports custom domains, SSL, SPA routing, and global edge caching.

## Features

- **S3 + CloudFront** — Global CDN with edge caching
- **SSL/HTTPS** — Auto-provisioned ACM certificate
- **Custom domain** — Route53 DNS records auto-created
- **SPA support** — React/Vue/Angular routing works out of the box
- **Secure** — S3 bucket is private, only CloudFront can access it (OAC)
- **Compressed** — Gzip/Brotli compression enabled
- **Versioned** — S3 versioning for rollback support

## Usage

### Basic (CloudFront URL only)

```hcl
module "site" {
  source = "github.com/akshayghalme/terraform-s3-cloudfront-site"

  bucket_name = "my-awesome-site"

  tags = { Project = "portfolio" }
}

# After apply:
# website_url = "https://d1234abcdef.cloudfront.net"
```

### With Custom Domain + SSL

```hcl
module "site" {
  source = "github.com/akshayghalme/terraform-s3-cloudfront-site"

  bucket_name               = "example-com-site"
  domain_name               = "example.com"
  subject_alternative_names = ["www.example.com"]
  route53_zone_id           = "Z1234567890"

  tags = { Project = "website" }
}

# After apply:
# website_url = "https://example.com"
```

### React/Vue SPA

```hcl
module "site" {
  source = "github.com/akshayghalme/terraform-s3-cloudfront-site"

  bucket_name = "my-react-app"
  is_spa      = true  # Routes 404 → index.html

  tags = { Project = "frontend" }
}
```

## Deploying Your Files

After `terraform apply`, upload your site:

```bash
# Upload files
aws s3 sync ./build s3://YOUR_BUCKET_NAME --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation \
  --distribution-id YOUR_DISTRIBUTION_ID \
  --paths "/*"
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| `bucket_name` | S3 bucket name (globally unique) | required |
| `domain_name` | Custom domain | `""` |
| `route53_zone_id` | Route53 zone ID for DNS | `""` |
| `is_spa` | SPA mode (route 404 → index.html) | `false` |
| `price_class` | CloudFront pricing | `PriceClass_100` |
| `enable_versioning` | S3 versioning | `true` |

## Outputs

| Name | Description |
|------|-------------|
| `website_url` | Your site URL |
| `cloudfront_distribution_id` | For cache invalidation |
| `bucket_name` | For file uploads |

## Price Class Guide

| Class | Regions | Cost |
|-------|---------|------|
| `PriceClass_100` | US, Canada, Europe | Cheapest |
| `PriceClass_200` | + Asia, Middle East, Africa | Medium |
| `PriceClass_All` | All edge locations | Most expensive |

## License

MIT

## Author

**Akshay Ghalme** — [akshayghalme.com](https://akshayghalme.com)
