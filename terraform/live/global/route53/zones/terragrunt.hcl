terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-route53.git//modules/zones?ref=v4.1.0"
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
  zones = {
    "luisosuna.com" = {
      comment = "${local.domain_name} (production)"
      tags = {
        Name = local.domain_name
      }
    }
  }

  tags = local.tags
}