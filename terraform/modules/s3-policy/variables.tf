variable "bucket" {
  description = "The name of the existing S3 bucket to be used by CloudFront for storing or accessing content."
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "CloudFront distribution ARN."
  type        = string
}
