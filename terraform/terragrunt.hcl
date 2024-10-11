terraform_version_constraint  = ">= 1.5.6"
terragrunt_version_constraint = ">= 0.50.2"

locals {
  global_variables = read_terragrunt_config(find_in_parent_folders("global_variables.hcl"))
  product          = local.global_variables.locals.product
  aws_region       = get_env("TF_VAR_region", "us-east-1")
  account_id       = get_env("TF_VAR_account_id")
  role_arn         = "arn:aws:iam::${local.account_id}:role/cicd_deployer"
}

# Merge local values (adjust inputs based on requirements)
inputs = merge(
  {
    aws_region = local.aws_region
  }
)

# Remote state configuration
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = get_env("TF_VAR_s3_bucket", "operations-tfstate-teby2plr")
    key            = "${local.account_id}/${local.product}/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = get_env("TF_VAR_dynamodb_table", "operations-tfstate")
    acl            = "bucket-owner-full-control"
  }
}

# Generate AWS provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "aws" {
      region = "${local.aws_region}"
      allowed_account_ids = ["${local.account_id}"]
      assume_role {
        role_arn = "${local.role_arn}"
      }
    }
  EOF
}

# Retry configuration for locking
terraform {
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=10m"]
  }
}

# Lock file generation for specific provider versions
generate "locks" {
  path      = ".terraform.lock.hcl"
  if_exists = "skip"
  contents  = <<-LOCKS
    provider "registry.terraform.io/hashicorp/aws" {
        version     = "5.70.0"
        constraints = "~> 5.70.0"
        hashes = [
            "h1:F0Xy1oGTyjjr4VLvCuscnjuIP26roJhveM87hZIcU3E=",
            "zh:09cbec93c324e6f03a866244ecb2bae71fdf1f5d3d981e858b745c90606b6b6d",
            "zh:19685d9f4c9ddcfa476a9a428c6c612be4a1b4e8e1198fbcbb76436b735284ee",
            "zh:3358ee6a2b24c982b7c83fac0af6898644d1bbdabf9c4e0589e91e427641ba88",
            "zh:34f9f2936de7384f8ed887abdbcb54aea1ce7b0cf2e85243a3fd3904d024747f",
            "zh:4a99546cc2140304c90d9ccb9db01589d4145863605a0fcd90027a643ea3ec5d",
            "zh:4da32fec0e10dab5aa3dea3c9fe57adc973cc73a71f5d59da3f65d85d925dc3f",
            "zh:659cf94522bc38ce0af70f7b0371b2941a0e0bcad02d17c1a7b264575fe07224",
            "zh:6f1c172c9b98bc86e4f0526872098ee3246c2620f7b323ce0c2ce6427987f7d2",
            "zh:79bf8fb8f37c308742e287694a9de081ff8502b065a390d1bcfbd241b4eca203",
            "zh:9b12af85486a96aedd8d7984b0ff811a4b42e3d88dad1a3fb4c0b580d04fa425",
            "zh:b7a5e1dfd9e179d70a169ddd4db44b56da90309060e27d36b329fe5fb3528e29",
            "zh:c2cc728cb18ffd5c4814a10c203452c71f5ab0c46d68f9aa9183183fa60afd87",
            "zh:c89bb37d2b8947c9a0d62b0b86ace51542f3327970f4e56a68bf81d9d0b8b65b",
            "zh:ef2a61e8112c3b5e70095508aadaadf077e904b62b9cfc22030337f773bba041",
            "zh:f714550b858d141ea88579f25247bda2a5ba461337975e77daceaf0bb7a9c358",
        ]
    }
  LOCKS
}
