resource "aws_s3_bucket_policy" "oac_bucket_policy" {
  bucket = var.bucket

  policy = templatefile("origin_access_control_policy.json", {
    bucket_name        = var.bucket,
    distribution_arn   = var.cloudfront_distribution_arn
  })
}