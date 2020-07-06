resource "aws_cloudwatch_log_group" "ssm" {
  count             = var.cloudwatch_group_enabled ? 1 : 0
  name              = "/aws/ssm/${module.label.id}"
  retention_in_days = var.cloudwatch_retention_in_days
  kms_key_id        = var.kms_enabled ? module.kms-key.key_id : null
  tags              = module.label.tags
}
