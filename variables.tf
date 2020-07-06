variable "namespace" {
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  type        = string
  default     = ""
}

variable "name" {
  description = "Solution name, e.g. 'app' or 'jenkins'"
  type        = string
  default     = ""
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
  type        = map(string)
  default     = {}
}

variable "principals" {
  description = "Map of principal type and a list of ARNs to allow access bucket and kms (e.g. `map('AWS', list('arn:aws:iam:::role/admin'))`)"
  type        = map(any)
  default     = {}
}

variable "bucket_enabled" {
  description = "Set to `false` to prevent the module from creating S3 bucket"
  type        = bool
  default     = false
}

variable "bucket_force_destroy" {
  type        = bool
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  default     = false
}

variable "bucket_acl" {
  description = "The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services"
  type        = string
  default     = "log-delivery-write"
}

variable "bucket_lifecycle_rule_enabled" {
  description = "Enable lifecycle events on this bucket"
  type        = bool
  default     = false
}

variable "bucket_expiration_days" {
  description = "Number of days after which to expunge the objects"
  default     = 90
}

variable "bucket_lifecycle_prefix" {
  type        = string
  description = "Prefix filter. Used to manage object lifecycle events"
  default     = ""
}

variable "bucket_lifecycle_tags" {
  description = "Tags filter. Used to manage object lifecycle events"
  type        = map(string)
  default     = {}
}

variable "bucket_enable_standard_transition" {
  type        = bool
  default     = false
  description = "Enables the transition to AWS STANDARD IA"
}

variable "bucket_standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  default     = 30
}

variable "bucket_enable_glacier_transition" {
  description = "Glacier transition might just increase your bill. Set to false to disable lifecycle transitions to AWS Glacier"
  type        = bool
  default     = false
}

variable "bucket_glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = 60
}

variable "bucket_kms_generated" {
  description = "Set to `true` to use auto generated KMS CMK key for bucket encryption"
  type        = bool
  default     = false
}

variable "bucket_kms_master_key_arn" {
  description = "The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  type        = string
  default     = ""
}

variable "kms_enabled" {
  description = "Set to false to prevent the module from automatic KMS key creation"
  type        = bool
  default     = false
}

variable "kms_description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
  default     = "KMS key to encrypt the logs delivered by SSM session manager"
}

variable "kms_alias" {
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash, leave default for auto generated alias"
  type        = string
  default     = ""
}

variable "kms_enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = false
}

variable "cloudwatch_group_enabled" {
  description = "Set to `false` to prevent the module from creating CloudWatch log group"
  type        = bool
  default     = false
}

variable "cloudwatch_retention_in_days" {
  description = "Number of days you want to retain log events in the log group"
  default     = 30
}
