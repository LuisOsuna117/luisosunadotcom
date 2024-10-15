terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-acm.git//?ref=v5.1.1"
}

include {
  path = find_in_parent_folders()
}

dependency route53-zone {
  config_path = "${path_relative_from_include()}/live/global/route53/zones"

  mock_outputs = {
    route53_zone_zone_id = "Z123456789EXAMPLE"
  }
  mock_outputs_merge_strategy_with_state  = "shallow"
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
  providers = {
    aws.acm = aws
    aws.dns = aws
  }

  domain_name = local.domain_name
  zone_id     = dependency.route53-zone.outputs.route53_zone_zone_id

  validation_method = "DNS"

  tags = {
    Name = local.domain_name
  }
}
