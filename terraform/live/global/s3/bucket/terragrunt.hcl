terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git//.?ref=v4.2.0"
}

include {
  path = find_in_parent_folders()
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

  tags = local.tags
}
