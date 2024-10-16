terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-acm.git/?ref=v5.1.1"
}

include {
  path = find_in_parent_folders()
}

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
  domain_name = local.domain_name
  zone_id     = "Z0678736OILCV25F1T2N"

  subject_alternative_names = ["*.${local.domain_name}"]

  validation_method = "DNS"

  tags = local.tags
}
