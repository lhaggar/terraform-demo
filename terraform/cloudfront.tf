locals {
  origin_id     = "s3origin-${aws_s3_bucket.website.id}"
  origin_domain = aws_s3_bucket.website.website_endpoint
}

data "aws_cloudfront_cache_policy" "website" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_distribution" "website" {
  origin {
    origin_id   = local.origin_id
    domain_name = local.origin_domain

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    cache_policy_id  = data.aws_cloudfront_cache_policy.website.id
    target_origin_id = local.origin_id

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }


  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.website.domain_name
}
