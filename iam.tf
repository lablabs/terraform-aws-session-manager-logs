data "aws_iam_policy_document" "instance" {
  # SSM session manager bucket policy
  statement {
    sid    = "S3BucketAccessForSessionManager"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectVersionAcl"
    ]
    resources = [
      "arn:aws:s3:::${module.label.id}/*",
      "arn:aws:s3:::${module.label.id}"
    ]
  }

  statement {
    sid    = "S3EncryptionForSessionManager"
    effect = "Allow"
    actions = [
      "s3:GetEncryptionConfiguration"
    ]
    resources = [
      "arn:aws:s3:::${module.label.id}"
    ]
  }

  # SSM session manager cloudwatch policy
  statement {
    sid = "AllowCloudWatchLogsAccessForSessionManager"

    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    resources = var.cloudwatch_group_enabled ? [aws_cloudwatch_log_group.ssm[0].arn] : ["*"]
  }

  # SSM session manager KMS key policy
  dynamic "statement" {
    for_each = local.kms_enabled ? [1] : []

    content {
      sid = "KMSEncryptionForSessionManager"

      actions = [
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:Decrypt",
        "kms:Encrypt",
      ]

      resources = [
        module.kms-key.key_arn
      ]
    }
  }
}
