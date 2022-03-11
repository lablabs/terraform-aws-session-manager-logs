locals {
  kms_alias   = var.kms_alias == "" ? "alias/${module.label.id}" : var.kms_alias
  kms_enabled = var.kms_enabled || var.bucket_kms_generated ? true : false
}

data "aws_caller_identity" "kms" {}

data "aws_iam_policy_document" "kms" {
  statement {
    sid       = "AllowKMSAllForOwnerAccount"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.kms.account_id}:root"]
      type        = "AWS"
    }
  }

  dynamic "statement" {
    for_each = length(var.principals) > 0 ? [1] : []

    content {
      sid    = "AllowKMSUsageCrossAccount"
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = ["*"]

      dynamic "principals" {
        for_each = var.principals
        content {
          identifiers = principals.value
          type        = principals.key
        }
      }
    }
  }

  statement {
    sid    = "AllowKeyUsageInCloudWatch"
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]

    resources = ["*"]

    principals {
      identifiers = ["logs.amazonaws.com"]
      type        = "Service"
    }
  }
}

module "kms-key" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.1"

  namespace   = module.label.namespace
  environment = module.label.environment
  name        = module.label.name
  attributes  = module.label.attributes
  tags        = module.label.tags

  enabled     = local.kms_enabled
  description = var.kms_description
  alias       = local.kms_alias
  policy      = join("", data.aws_iam_policy_document.kms.*.json)
}
