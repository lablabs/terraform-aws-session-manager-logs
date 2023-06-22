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

variable "bucket_versioning_enabled" {
  type        = bool
  default     = false
  description = "A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket"
}

variable "bucket_acl" {
  description = "The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services"
  type        = string
  default     = "log-delivery-write"
}

variable "bucket_lifecycle_configuration_rules" { # New stuff
  type        = list(any)
  description = "Lifecycle configuration rules"
  default     = []
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

variable "cloudwatch_group_enabled" {
  description = "Set to `false` to prevent the module from creating CloudWatch log group"
  type        = bool
  default     = false
}

variable "cloudwatch_retention_in_days" {
  type        = number
  description = "Number of days you want to retain log events in the log group"
  default     = 30
}
