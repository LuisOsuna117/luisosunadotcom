terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-cloudfront.git/?ref=v3.4.1"
}

include {
  path = find_in_parent_folders()
}

dependency "s3-bucket" {
  config_path = "../s3"

  mock_outputs = {
    domain_name = "mock-bucket.s3.amazonaws.com"
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "providers", "init"]
}

// dependency acm {
//   config_path = "${path_relative_from_include()}/live/global/acm"

//   mock_outputs = {
//     acm_certificate_arn = "arn:aws:acm:us-west-2:123456789012:certificate/abc12345-6789-0123-abcd-1234567890ab"
//   }

//   mock_outputs_allowed_terraform_commands = ["validate", "plan", "providers", "init"]
// }

locals {
  global_variables = read_terragrunt_config(find_in_parent_folders("global_variables.hcl"))

  product     = local.global_variables.locals.product
  domain_name = "luisosuna.com"

  tags = {
    "iac-path" = path_relative_to_include()
    "Name"     = local.product
  }
}

inputs = {
  // aliases     = ["${local.domain_name}"]
  price_class = "PriceClass_100"

  create_origin_access_control = true

  origin_access_control = {
    s3_oac = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    s3 = {
      domain_name           = dependency.s3-bucket.outputs.s3_bucket_bucket_domain_name
      origin_access_control = "s3_oac"
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true

  }

  // viewer_certificate = {
  //   acm_certificate_arn = dependency.acm.outputs.acm_certificate_arn
  //   ssl_support_method  = "sni-only"
  // }

  tags = local.tags
}
