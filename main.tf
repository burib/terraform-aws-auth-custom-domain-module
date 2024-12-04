# Cognito User Pool Domain
resource "aws_cognito_user_pool_domain" "this" {
  domain          = var.auth_domain
  certificate_arn = var.wildcard_certificate_arn
  user_pool_id    = var.aws_cognito_user_pool_id

  depends_on = [var.domain_records_created]

  lifecycle {
    create_before_destroy = true
  }
}

# Route53 Records for Auth Domain
resource "aws_route53_record" "auth_domain" {
  zone_id = var.route53_zone_id
  name    = var.auth_domain
  type    = "A"

  alias {
    name                   = aws_cognito_user_pool_domain.this.cloudfront_distribution_arn
    zone_id                = aws_cognito_user_pool_domain.this.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "auth_domain_ipv6" {
  zone_id = var.route53_zone_id
  name    = var.auth_domain
  type    = "AAAA"

  alias {
    name                   = aws_cognito_user_pool_domain.this.cloudfront_distribution_arn
    zone_id                = aws_cognito_user_pool_domain.this.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    create_before_destroy = true
  }
}

# https://docs.aws.amazon.com/cognito/latest/developerguide/hosted-ui-classic-branding.html
# https://aws.amazon.com/blogs/security/use-the-hosted-ui-or-create-a-custom-ui-in-amazon-cognito/
resource "aws_cognito_user_pool_ui_customization" "main" {
  client_id    = var.aws_cognito_user_pool_client_id
  user_pool_id = var.aws_cognito_user_pool_id
  depends_on = [
    aws_route53_record.auth_domain,
    aws_route53_record.auth_domain_ipv6
  ]

  css = <<EOF
    .background-customizable {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
    }

    .banner-customizable {
      background-color: #6E5DC6;
    }

    .label-customizable {
    }

    .textDescription-customizable {
    }

    .inputField-customizable {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif;
    }

    .inputField-customizable:focus {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif;
      box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(9,136,112,.6);
      border-color: #098870;
    }

    .redirect-customizable {

    }

    .submitButton-customizable {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif;
      border-color: #6E5DC6;
      background: #6E5DC6;
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 6px;
      font-weight: 600;
      transition: all 0.2s ease;
      text-decoration: none;
      font-size: 14px;
    }

    .submitButton-customizable:hover {
      background: white;
      border-color: #6E5DC6;
      color: #6E5DC6;
    }

    .errorMessage-customizable {
    }

    .socialButton-customizable {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif;
    }

    .legalText-customizable {
    }
EOF
}

