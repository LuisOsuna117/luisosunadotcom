terraform {
  source = "../../../..//modules/s3-policy"
}

include {
  path = find_in_parent_folders()
}

dependency "s3-bucket" {
  config_path = "${path_relative_from_include()}/live/global/s3/bucket"

  mock_outputs = {
    s3_bucket_id = "mock-bucket"
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "providers", "init"]
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
  bucket                      = dependency.s3-bucket.outputs.s3_bucket_id
  cloudfront_distribution_arn = dependency.cloudfront.outputs.cloudfront_distribution_arn
}
