variable "aws_cognito_user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
  type        = string
}

variable "aws_cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  type        = string
}

variable "wildcard_certificate_arn" {
  description = "The ARN of the wildcard certificate"
  type        = string
}

variable "auth_domain" {
  description = "auth domain of the hosted cognito ui."
  type        = string
}

variable "route53_zone_id" {
  description = "The Route53 Zone ID"
  type        = string
}

variable "domain_records_created" {
  description = "Map of domain records from cloudfront module"
  type = object({
    a_record    = string
    aaaa_record = string
    www_records = list(string)
  })
}
