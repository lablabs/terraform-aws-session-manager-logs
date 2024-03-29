output "bucket_domain_name" {
  description = "Session manager log bucket FQDN"
  value       = module.ssm-bucket.bucket_domain_name
}

output "bucket_id" {
  description = "Session manager log bucket ID"
  value       = module.ssm-bucket.bucket_id
}

output "bucket_arn" {
  description = "Session manager log bucket ARN"
  value       = module.ssm-bucket.bucket_arn
}

output "kms_key_arn" {
  description = "Session manager log KMS key ARN"
  value       = module.kms-key.key_arn
}

output "kms_key_id" {
  description = "Session manager log KMS key ID"
  value       = module.kms-key.key_id
}

output "kms_key_alias_name" {
  description = "Session manager log KMS key alias name"
  value       = module.kms-key.alias_name
}

output "kms_key_alias_arn" {
  description = "Session manager log KMS key alias ARN"
  value       = module.kms-key.alias_arn
}

output "cloudwatch_group_name" {
  description = "Session manager cloudwatch log group name"
  value       = element(concat(aws_cloudwatch_log_group.ssm[*].name, [""]), 0)
}

output "cloudwatch_group_arn" {
  description = "Session manager cloudwatch log group arn"
  value       = element(concat(aws_cloudwatch_log_group.ssm[*].arn, [""]), 0)
}

output "cloudwatch_group_retention_in_days" {
  description = "Session manager cloudwatch log group retention days"
  value       = element(concat(aws_cloudwatch_log_group.ssm[*].retention_in_days, [""]), 0)
}

output "cloudwatch_group_kms_key_id" {
  description = "Session manager cloudwatch log group kms key id"
  value       = element(concat(aws_cloudwatch_log_group.ssm[*].kms_key_id, [""]), 0)
}

output "policy_document" {
  description = "Session manager policy document for instance profile"
  value       = data.aws_iam_policy_document.instance
}
