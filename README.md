# AWS Session manager logs Terraform module

[![Labyrinth Labs logo](ll-logo.png)](https://www.lablabs.io)

We help companies build, run, deploy and scale software and infrastructure by embracing the right technologies and principles. Check out our website at https://lablabs.io/

---

![Terraform validation](https://github.com/lablabs/terraform-aws-session-manager-logs/workflows/Terraform%20validation/badge.svg?branch=master)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## Description

A terraform module to create AWS Session Manager logs resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms-key"></a> [kms-key](#module\_kms-key) | cloudposse/kms-key/aws | 0.12.1 |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_ssm-bucket"></a> [ssm-bucket](#module\_ssm-bucket) | cloudposse/s3-log-storage/aws | 0.28.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_caller_identity.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services | `string` | `"log-delivery-write"` | no |
| <a name="input_bucket_enable_glacier_transition"></a> [bucket\_enable\_glacier\_transition](#input\_bucket\_enable\_glacier\_transition) | Glacier transition might just increase your bill. Set to false to disable lifecycle transitions to AWS Glacier | `bool` | `false` | no |
| <a name="input_bucket_enable_standard_transition"></a> [bucket\_enable\_standard\_transition](#input\_bucket\_enable\_standard\_transition) | Enables the transition to AWS STANDARD IA | `bool` | `false` | no |
| <a name="input_bucket_enabled"></a> [bucket\_enabled](#input\_bucket\_enabled) | Set to `false` to prevent the module from creating S3 bucket | `bool` | `false` | no |
| <a name="input_bucket_expiration_days"></a> [bucket\_expiration\_days](#input\_bucket\_expiration\_days) | Number of days after which to expunge the objects | `number` | `90` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| <a name="input_bucket_glacier_transition_days"></a> [bucket\_glacier\_transition\_days](#input\_bucket\_glacier\_transition\_days) | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| <a name="input_bucket_kms_generated"></a> [bucket\_kms\_generated](#input\_bucket\_kms\_generated) | Set to `true` to use auto generated KMS CMK key for bucket encryption | `bool` | `false` | no |
| <a name="input_bucket_kms_master_key_arn"></a> [bucket\_kms\_master\_key\_arn](#input\_bucket\_kms\_master\_key\_arn) | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms | `string` | `""` | no |
| <a name="input_bucket_lifecycle_prefix"></a> [bucket\_lifecycle\_prefix](#input\_bucket\_lifecycle\_prefix) | Prefix filter. Used to manage object lifecycle events | `string` | `""` | no |
| <a name="input_bucket_lifecycle_rule_enabled"></a> [bucket\_lifecycle\_rule\_enabled](#input\_bucket\_lifecycle\_rule\_enabled) | Enable lifecycle events on this bucket | `bool` | `false` | no |
| <a name="input_bucket_lifecycle_tags"></a> [bucket\_lifecycle\_tags](#input\_bucket\_lifecycle\_tags) | Tags filter. Used to manage object lifecycle events | `map(string)` | `{}` | no |
| <a name="input_bucket_standard_transition_days"></a> [bucket\_standard\_transition\_days](#input\_bucket\_standard\_transition\_days) | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| <a name="input_bucket_versioning_enabled"></a> [bucket\_versioning\_enabled](#input\_bucket\_versioning\_enabled) | A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket | `bool` | `false` | no |
| <a name="input_cloudwatch_group_enabled"></a> [cloudwatch\_group\_enabled](#input\_cloudwatch\_group\_enabled) | Set to `false` to prevent the module from creating CloudWatch log group | `bool` | `false` | no |
| <a name="input_cloudwatch_retention_in_days"></a> [cloudwatch\_retention\_in\_days](#input\_cloudwatch\_retention\_in\_days) | Number of days you want to retain log events in the log group | `number` | `30` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `""` | no |
| <a name="input_kms_alias"></a> [kms\_alias](#input\_kms\_alias) | The display name of the alias. The name must start with the word `alias` followed by a forward slash, leave default for auto generated alias | `string` | `""` | no |
| <a name="input_kms_description"></a> [kms\_description](#input\_kms\_description) | The description of the key as viewed in AWS console | `string` | `"KMS key to encrypt the logs delivered by SSM session manager"` | no |
| <a name="input_kms_enable_key_rotation"></a> [kms\_enable\_key\_rotation](#input\_kms\_enable\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `false` | no |
| <a name="input_kms_enabled"></a> [kms\_enabled](#input\_kms\_enabled) | Set to false to prevent the module from automatic KMS key creation | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | Map of principal type and a list of ARNs to allow access bucket and kms (e.g. `map('AWS', list('arn:aws:iam:::role/admin'))`) | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | Session manager log bucket ARN |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | Session manager log bucket FQDN |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Session manager log bucket ID |
| <a name="output_cloudwatch_group_arn"></a> [cloudwatch\_group\_arn](#output\_cloudwatch\_group\_arn) | Session manager cloudwatch log group arn |
| <a name="output_cloudwatch_group_kms_key_id"></a> [cloudwatch\_group\_kms\_key\_id](#output\_cloudwatch\_group\_kms\_key\_id) | Session manager cloudwatch log group kms key id |
| <a name="output_cloudwatch_group_name"></a> [cloudwatch\_group\_name](#output\_cloudwatch\_group\_name) | Session manager cloudwatch log group name |
| <a name="output_cloudwatch_group_retention_in_days"></a> [cloudwatch\_group\_retention\_in\_days](#output\_cloudwatch\_group\_retention\_in\_days) | Session manager cloudwatch log group retention days |
| <a name="output_kms_key_alias_arn"></a> [kms\_key\_alias\_arn](#output\_kms\_key\_alias\_arn) | Session manager log KMS key alias ARN |
| <a name="output_kms_key_alias_name"></a> [kms\_key\_alias\_name](#output\_kms\_key\_alias\_name) | Session manager log KMS key alias name |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | Session manager log KMS key ARN |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | Session manager log KMS key ID |
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | Session manager policy document for instance profile |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing and reporting issues

Feel free to create an issue in this repository if you have questions, suggestions or feature requests.

### Validation, linters and pull-requests

We want to provide high quality code and modules. For this reason we are using
several [pre-commit hooks](.pre-commit-config.yaml) and
[GitHub Actions workflow](.github/workflows/main.yml). A pull-request to the
master branch will trigger these validations and lints automatically. Please
check your code before you will create pull-requests. See
[pre-commit documentation](https://pre-commit.com/) and
[GitHub Actions documentation](https://docs.github.com/en/actions) for further
details.


## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
