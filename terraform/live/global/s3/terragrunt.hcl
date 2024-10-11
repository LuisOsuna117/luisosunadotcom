terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git//?ref=v4.2.0"
}

include {
  path = find_in_parent_folders()
}

locals {
  s3_bucket_name = "luisosunadotcom"

  tags = { 
    "iac-path" = "${path_relative_to_include()}", 
    "Name" : local.s3_bucket_name 
  }
}

inputs = {
  bucket = local.s3_bucket_name

  tags = local.tags
}
