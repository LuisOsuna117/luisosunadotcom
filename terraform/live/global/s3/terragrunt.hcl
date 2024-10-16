terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git//?ref=v4.2.0"
}

include {
  path = find_in_parent_folders()
}

dependency "cloudfront" {
  config_path = "${path_relative_from_include()}/live/global/cloudfront"

  mock_outputs = {
    cloudfront_distribution_arn = "arn:aws:cloudfront::123456789012:distribution/E1AGE6REXAMPLE"
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "providers", "init"]
}

locals {
  global_variables = read_terragrunt_config(find_in_parent_folders("global_variables.hcl"))

  product = local.global_variables.locals.product

  tags = {
    "iac-path" = path_relative_to_include()
    "Name"     = local.product
  }
}

inputs = {
  bucket = local.product

  attach_policy = true

  policy = templatefile("origin_access_control_policy.json",{
    bucket_name        = local.product,
    distribution_arn   = dependency.cloudfront.outputs.cloudfront_distribution_arn
  })

  tags = local.tags
}
