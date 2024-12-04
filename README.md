# terraform-aws-auth-custom-domain-module ( beta )

#### This module is used to create a custom domain for cognito user pool. 
##### Use this module after creating cognito user pool and client, wildcard certificate and route53 zone, and wait for the top level domain records to be created ( for example by cloudfront for static website hosting ).

```terraform
 module "auth_custom_domain" {
    source = "github.com/burib/terraform-aws-auth-custom-domain-module?ref=v0"

    route53_zone_id                 = "REPLACE_WITH_ROUTE53_ZONE_ID_OF_TOP_LEVEL_DOMAIN_LIKE_EXAMPLE_COM"
    wildcard_certificate_arn        = "REPLACE_WITH_WILDCARD_CERTIFICATE_ARN"

    aws_cognito_user_pool_id        = "REPLACE_WITH_AWS_COGNITO_USER_POOL_ID"
    aws_cognito_user_pool_client_id = "REPLACE_WITH_AWS_COGNITO_USER_POOL_CLIENT_ID"
    auth_domain                     = "auth.example.com"
    domain_records_created          = "WAIT_FOR_TOP_TOP_DOMAIN_RECORDS_TO_BE_CREATED"
  }
```

