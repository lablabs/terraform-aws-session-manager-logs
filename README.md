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
| terraform | >= 0.13 |
| aws | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| kms-key | cloudposse/kms-key/aws | 0.9.1 |
| label | cloudposse/label/null | 0.24.1 |
| ssm-bucket | cloudposse/s3-log-storage/aws | 0.20.0 |

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| bucket\_acl | The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services | `string` | `"log-delivery-write"` | no |
| bucket\_enable\_glacier\_transition | Glacier transition might just increase your bill. Set to false to disable lifecycle transitions to AWS Glacier | `bool` | `false` | no |
| bucket\_enable\_standard\_transition | Enables the transition to AWS STANDARD IA | `bool` | `false` | no |
| bucket\_enabled | Set to `false` to prevent the module from creating S3 bucket | `bool` | `false` | no |
| bucket\_expiration\_days | Number of days after which to expunge the objects | `number` | `90` | no |
| bucket\_force\_destroy | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| bucket\_glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| bucket\_kms\_generated | Set to `true` to use auto generated KMS CMK key for bucket encryption | `bool` | `false` | no |
| bucket\_kms\_master\_key\_arn | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms | `string` | `""` | no |
| bucket\_lifecycle\_prefix | Prefix filter. Used to manage object lifecycle events | `string` | `""` | no |
| bucket\_lifecycle\_rule\_enabled | Enable lifecycle events on this bucket | `bool` | `false` | no |
| bucket\_lifecycle\_tags | Tags filter. Used to manage object lifecycle events | `map(string)` | `{}` | no |
| bucket\_standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| cloudwatch\_group\_enabled | Set to `false` to prevent the module from creating CloudWatch log group | `bool` | `false` | no |
| cloudwatch\_retention\_in\_days | Number of days you want to retain log events in the log group | `number` | `30` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `""` | no |
| kms\_alias | The display name of the alias. The name must start with the word `alias` followed by a forward slash, leave default for auto generated alias | `string` | `""` | no |
| kms\_description | The description of the key as viewed in AWS console | `string` | `"KMS key to encrypt the logs delivered by SSM session manager"` | no |
| kms\_enable\_key\_rotation | Specifies whether key rotation is enabled | `bool` | `false` | no |
| kms\_enabled | Set to false to prevent the module from automatic KMS key creation | `bool` | `false` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `""` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| principals | Map of principal type and a list of ARNs to allow access bucket and kms (e.g. `map('AWS', list('arn:aws:iam:::role/admin'))`) | `map(any)` | `{}` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | Session manager log bucket ARN |
| bucket\_domain\_name | Session manager log bucket FQDN |
| bucket\_id | Session manager log bucket ID |
| cloudwatch\_group\_arn | Session manager cloudwatch log group arn |
| cloudwatch\_group\_kms\_key\_id | Session manager cloudwatch log group kms key id |
| cloudwatch\_group\_name | Session manager cloudwatch log group name |
| cloudwatch\_group\_retention\_in\_days | Session manager cloudwatch log group retention days |
| kms\_key\_alias\_arn | Session manager log KMS key alias ARN |
| kms\_key\_alias\_name | Session manager log KMS key alias name |
| kms\_key\_arn | Session manager log KMS key ARN |
| kms\_key\_id | Session manager log KMS key ID |
| policy\_document | Session manager policy document for instance profile |
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
