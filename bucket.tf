locals {
  sse_algorithm      = (var.bucket_kms_generated || length(var.bucket_kms_master_key_arn) > 0) ? "aws:kms" : "AES256"
  kms_master_key_arn = var.bucket_kms_generated ? module.kms-key.key_arn : var.bucket_kms_master_key_arn
}

module "ssm-bucket" {
  source  = "cloudposse/s3-log-storage/aws"
  version = "0.28.0"

  namespace   = module.label.namespace
  environment = module.label.environment
  name        = module.label.name
  attributes  = module.label.attributes
  tags        = module.label.tags

  enabled                   = var.bucket_enabled
  force_destroy             = var.bucket_force_destroy
  policy                    = data.aws_iam_policy_document.bucket.json
  acl                       = var.bucket_acl
  sse_algorithm             = local.sse_algorithm
  kms_master_key_arn        = local.kms_master_key_arn
  lifecycle_rule_enabled    = var.bucket_lifecycle_rule_enabled
  expiration_days           = var.bucket_expiration_days
  lifecycle_prefix          = var.bucket_lifecycle_prefix
  lifecycle_tags            = var.bucket_lifecycle_tags
  standard_transition_days  = var.bucket_standard_transition_days
  enable_glacier_transition = var.bucket_enable_glacier_transition
  glacier_transition_days   = var.bucket_glacier_transition_days
  versioning_enabled        = var.bucket_versioning_enabled

}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "S3EncryptionForSessionManager"
    effect = "Allow"
    actions = [
      "s3:GetEncryptionConfiguration"
    ]
    resources = [
      "arn:aws:s3:::${module.label.id}"
    ]

    dynamic "principals" {
      for_each = var.principals
      content {
        identifiers = principals.value
        type        = principals.key
      }
    }
  }

  statement {
    sid    = "S3BucketAccessForSessionManager"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectVersionAcl",
    ]
    resources = [
      "arn:aws:s3:::${module.label.id}/*",
      "arn:aws:s3:::${module.label.id}"
    ]

    dynamic "principals" {
      for_each = var.principals
      content {
        identifiers = principals.value
        type        = principals.key
      }
    }
  }
}
