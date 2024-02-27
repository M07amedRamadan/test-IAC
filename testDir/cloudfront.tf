# No change required in this file

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for private connectivity to S3"
}

resource "aws_cloudfront_distribution" "s3_distribution" {

  origin {
    domain_name = "${var.CUSTOMER_NAME}.vultara.com.s3.${var.region}.amazonaws.com"
    origin_id   = "${var.CUSTOMER_NAME}.vultara.com.s3.${var.region}.amazonaws.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  is_ipv6_enabled     = true
  enabled             = true
  default_root_object = "index.html"


  #Error Pages CloudFront
  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  #Cache Behavior for CloudFront
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.CUSTOMER_NAME}.vultara.com.s3.${var.region}.amazonaws.com"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    viewer_protocol_policy = "redirect-to-https"
  }

  aliases     = ["${var.CUSTOMER_NAME}.vultara.com"]
  price_class = "PriceClass_100"  #double check that it will be  use and canada

  # Geographical Restrictions
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  #CloudFront Tag
  tags = {
    Environment = "Production"
  }

}
