output "region" {
  value       = local.region
  description = "AWS Region code where this stack has been deployed to."
}

output "account_id" {
  value       = local.account_id
  description = "AWS Account ID where this stack has been deployed to."
}

output "cloudfront_distribution_arn" {
  value       = aws_cognito_user_pool_domain.this.cloudfront_distribution_arn
  description = "The ARN of the CloudFront distribution for the Cognito domain"
}

output "cloudfront_distribution_zone_id" {
  value       = aws_cognito_user_pool_domain.this.cloudfront_distribution_zone_id
  description = "The Zone ID of the CloudFront distribution for the Cognito domain"
}
