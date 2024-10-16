terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-route53.git//modules/records?ref=v4.1.0"
}

include {
  path = find_in_parent_folders()
}

dependency "cloudfront" {
  config_path = "${path_relative_from_include()}/live/global/cloudfront"

  mock_outputs = {
    cloudfront_distribution_domain_name = "d3m454zexample.cloudfront.net",
    cloudfront_distribution_hosted_zone_id = "Z2FD4NDEXAMPLE"
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "providers", "init"]
}

dependency "route53-zone" {
  config_path = "${path_relative_from_include()}/live/global/route53/zones"

  mock_outputs = {
    route53_zone_zone_id = {
      "luisosuna.com" = "Z0678736OILCVEXAMPLE"
    }
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "providers", "init"]
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
  zone_id = dependency.route53-zone.outputs.route53_zone_zone_id["luisosuna.com"]
  records = [
    {
      name = "cloudfront"
      type = "A"
      alias = {
        name    = dependency.cloudfront.outputs.cloudfront_distribution_domain_name
        zone_id = dependency.cloudfront.outputs.cloudfront_distribution_hosted_zone_id
      }
    },
  ]

  tags = local.tags
}