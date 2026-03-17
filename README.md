# Standard Platform - Terraform Module 🚀🚀
<p align="right"><a href="https://partners.amazonaws.com/partners/0018a00001hHve4AAC/GoCloud"><img src="https://img.shields.io/badge/AWS%20Partner-Advanced-orange?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS Partner"/></a><a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-green?style=for-the-badge&logo=apache&logoColor=white" alt="LICENSE"/></a></p>

Welcome to the Standard Platform — a suite of reusable and production-ready Terraform modules purpose-built for AWS environments.
Each module encapsulates best practices, security configurations, and sensible defaults to simplify and standardize infrastructure provisioning across projects.

## 📦 Module: Terraform OpenSearch Module
<p align="right"><a href="https://github.com/gocloudLa/terraform-aws-wrapper-opensearch/releases/latest"><img src="https://img.shields.io/github/v/release/gocloudLa/terraform-aws-wrapper-opensearch.svg?style=for-the-badge" alt="Latest Release"/></a><a href=""><img src="https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-wrapper-opensearch.svg?style=for-the-badge" alt="Last Commit"/></a><a href="https://registry.terraform.io/modules/gocloudLa/wrapper-opensearch/aws"><img src="https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Registry"/></a></p>
The Terraform wrapper for OpenSearch simplifies the configuration of the Amazon OpenSearch Service in the AWS cloud. This wrapper functions as a predefined template, facilitating the creation and management of OpenSearch domains by handling all the technical details.

### ✨ Features

- 🔍 [Node to Node Encryption](#node-to-node-encryption) - Enables node-to-node encryption

- 🔐 [Fine-Grained Access Control](#fine-grained-access-control) - Configures Advanced Security Options

- ⚙️ [Auto-Tune](#auto-tune) - Configures Auto-Tune Options

- 🌐 [VPC Deployments](#vpc-deployments) - Secure Internal Access



### 🔗 External Modules
| Name | Version |
|------|------:|
| <a href="https://github.com/terraform-aws-modules/terraform-aws-opensearch" target="_blank">terraform-aws-modules/opensearch/aws</a> | 2.5.0 |
| <a href="https://github.com/terraform-aws-modules/terraform-aws-security-group" target="_blank">terraform-aws-modules/security-group/aws</a> | 5.3.1 |



## 🚀 Quick Start
```hcl
opensearch_parameters = {
  example = {
    advanced_options = {
      "rest.action.multi.allow_explicit_index" = "true"
    }

    advanced_security_options = {
      enabled                        = false
      anonymous_auth_enabled         = true
      internal_user_database_enabled = true

      master_user_options = {
        master_user_name     = "example"
        master_user_password = "Barbarbarbar1!"
      }
    }

    cluster_config = {
      instance_count           = 3
      dedicated_master_enabled = true
      dedicated_master_type    = "c6g.large.search"
      instance_type            = "r6g.large.search"

      zone_awareness_enabled = true
      zone_awareness_config = {
        availability_zone_count = 3
      }
    }

    domain_endpoint_options = {
      enforce_https       = true
      tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
    }

    domain_name = "my-opensearch-domain"

    ebs_options = {
      ebs_enabled = true
      iops        = 3000
      throughput  = 125
      volume_size = 20
      volume_type = "gp3"
    }

    encrypt_at_rest = {
      enabled = true
    }

    engine_version = "OpenSearch_2.13"

    node_to_node_encryption = {
      enabled = true
    }

    software_update_options = {
      auto_software_update_enabled = true
    }

    vpc_options = {
      subnet_ids = data.aws_subnets.private.ids
    }

    security_group_rules = {
      ingress_443 = {
        type        = "ingress"
        description = "HTTPS access from VPC"
        from_port   = 443
        to_port     = 443
        ip_protocol = "tcp"
        cidr_ipv4   = data.aws_vpc.vpc.cidr_block
      }
    }
  }
}

opensearch_defaults = var.opensearch_defaults
```


## 🔧 Additional Features Usage

### Node to Node Encryption
Easily toggle node-to-node encryption for your OpenSearch domain to ensure data in transit between cluster nodes is secure.



### Fine-Grained Access Control
Allows fine-grained access control using an internal user database, SAML authentication, or Amazon Cognito integration for Kibana/OpenSearch Dashboards.



### Auto-Tune
Easily configure and manage Auto-Tune and its maintenance schedules to optimize your OpenSearch cluster's behavior automatically over time.



### VPC Deployments
Deploy your cluster directly into a VPC, with native support for configuring security group rules directly via the `security_group_rules` block.





## 📑 Inputs
| Name                                    | Description                                                                                                                                                                                                                                                                                | Type                                                                                                                                                                          | Default                                                                       | Required |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | -------- |
| access_policies                         | IAM policy document specifying the access policies for the domain. Required if `create_access_policy` is `false`                                                                                                                                                                           | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| access_policy_override_policy_documents | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid`                                                                                                                | `list(string)`                                                                                                                                                                | `[]`                                                                          | no       |
| access_policy_source_policy_documents   | List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s                                                                                                                                                                       | `list(string)`                                                                                                                                                                | `[]`                                                                          | no       |
| access_policy_statements                | A map of IAM policy statements for custom permission usage                                                                                                                                                                                                                                 | `any`                                                                                                                                                                         | `{}`                                                                          | no       |
| advanced_options                        | Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply | `map(string)`                                                                                                                                                                 | `{}`                                                                          | no       |
| advanced_security_options               | Configuration block for fine-grained access control                                                                                                                                                                                                                                        | `any`                                                                                                                                                                         | `{"anonymous_auth_enabled": false,"enabled": true}`                           | no       |
| aiml_options                            | Configuration block for Natural Language Query Generation and s3 Vectors                                                                                                                                                                                                                   | `object({natural_language_query_generation_options = optional(object({desired_state = optional(string)})),s3_vectors_engine = optional(object({enabled = optional(bool)}))})` | `null`                                                                        | no       |
| auto_tune_options                       | Configuration block for the Auto-Tune options of the domain                                                                                                                                                                                                                                | `any`                                                                                                                                                                         | `{"desired_state": "ENABLED","rollback_on_disable": "NO_ROLLBACK"}`           | no       |
| cloudwatch_log_group_class              | Specified the log class of the log group. Possible values are: STANDARD or INFREQUENT_ACCESS                                                                                                                                                                                               | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| cloudwatch_log_group_kms_key_id         | If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group.                                                                                                                                                                                                     | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| cloudwatch_log_group_retention_in_days  | Number of days to retain log events                                                                                                                                                                                                                                                        | `number`                                                                                                                                                                      | `60`                                                                          | no       |
| cloudwatch_log_group_skip_destroy       | Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state                                                                                                                   | `bool`                                                                                                                                                                        | `null`                                                                        | no       |
| cloudwatch_log_resource_policy_name     | Name of the resource policy for OpenSearch to log to CloudWatch                                                                                                                                                                                                                            | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| cluster_config                          | Configuration block for the cluster of the domain                                                                                                                                                                                                                                          | `any`                                                                                                                                                                         | `{"dedicated_master_enabled": true}`                                          | no       |
| cognito_options                         | Configuration block for authenticating Kibana with Cognito                                                                                                                                                                                                                                 | `any`                                                                                                                                                                         | `{}`                                                                          | no       |
| create                                  | Determines whether resources will be created (affects all resources)                                                                                                                                                                                                                       | `bool`                                                                                                                                                                        | `true`                                                                        | no       |
| create_access_policy                    | Determines whether an access policy will be created                                                                                                                                                                                                                                        | `bool`                                                                                                                                                                        | `true`                                                                        | no       |
| create_cloudwatch_log_groups            | Determines whether log groups are created                                                                                                                                                                                                                                                  | `bool`                                                                                                                                                                        | `true`                                                                        | no       |
| create_cloudwatch_log_resource_policy   | Determines whether a resource policy will be created for OpenSearch to log to CloudWatch                                                                                                                                                                                                   | `bool`                                                                                                                                                                        | `true`                                                                        | no       |
| create_saml_options                     | Determines whether SAML options will be created                                                                                                                                                                                                                                            | `bool`                                                                                                                                                                        | `false`                                                                       | no       |
| create_security_group                   | Determines if a security group is created                                                                                                                                                                                                                                                  | `bool`                                                                                                                                                                        | `true`                                                                        | no       |
| domain_endpoint_options                 | Configuration block for domain endpoint HTTP(S) related options                                                                                                                                                                                                                            | `any`                                                                                                                                                                         | `{"enforce_https": true,"tls_security_policy": "Policy-Min-TLS-1-2-2019-07"}` | no       |
| domain_name                             | Name of the domain                                                                                                                                                                                                                                                                         | `string`                                                                                                                                                                      | `""`                                                                          | no       |
| ebs_options                             | Configuration block for EBS related options, may be required based on chosen instance size                                                                                                                                                                                                 | `any`                                                                                                                                                                         | `{"ebs_enabled": true,"volume_size": 64,"volume_type": "gp3"}`                | no       |
| enable_access_policy                    | Determines whether an access policy will be applied to the domain                                                                                                                                                                                                                          | `bool`                                                                                                                                                                        | `true`                                                                        | no       |
| encrypt_at_rest                         | Configuration block for encrypting at rest                                                                                                                                                                                                                                                 | `any`                                                                                                                                                                         | `{"enabled": true}`                                                           | no       |
| engine_version                          | Version of the OpenSearch engine to use. Must follow format 'OpenSearch_X.Y' (e.g., 'OpenSearch_2.11')                                                                                                                                                                                     | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| identity_center_options                 | Configuration block for enabling and managing IAM Identity Center integration within a domain                                                                                                                                                                                              | `object({enabled_api_access = optional(bool),identity_center_instance_arn = optional(string),roles_key = optional(string),subject_key = optional(string)})`                   | `null`                                                                        | no       |
| ip_address_type                         | The IP address type for the endpoint. Valid values are ipv4 and dualstack                                                                                                                                                                                                                  | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| log_publishing_options                  | Configuration block for publishing slow and application logs to CloudWatch Logs. This block can be declared multiple times, for each log_type, within the same resource                                                                                                                    | `any`                                                                                                                                                                         | `[{"log_type": "INDEX_SLOW_LOGS"},{"log_type": "SEARCH_SLOW_LOGS"}]`          | no       |
| node_to_node_encryption                 | Configuration block for node-to-node encryption options                                                                                                                                                                                                                                    | `any`                                                                                                                                                                         | `{"enabled": true}`                                                           | no       |
| off_peak_window_options                 | Configuration to add Off Peak update options                                                                                                                                                                                                                                               | `any`                                                                                                                                                                         | `{"enabled": true,"off_peak_window": {"hours": 7}}`                           | no       |
| outbound_connections                    | Map of AWS OpenSearch outbound connections to create                                                                                                                                                                                                                                       | `any`                                                                                                                                                                         | `{}`                                                                          | no       |
| package_associations                    | Map of package association IDs to associate with the domain                                                                                                                                                                                                                                | `map(string)`                                                                                                                                                                 | `{}`                                                                          | no       |
| region                                  | Region where this resource will be managed. Defaults to the Region set in the provider configuration                                                                                                                                                                                       | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| saml_options                            | SAML authentication options for an AWS OpenSearch Domain                                                                                                                                                                                                                                   | `any`                                                                                                                                                                         | `{}`                                                                          | no       |
| security_group_description              | Description of the security group created                                                                                                                                                                                                                                                  | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| security_group_name                     | Name to use on security group created                                                                                                                                                                                                                                                      | `string`                                                                                                                                                                      | `null`                                                                        | no       |
| security_group_rules                    | Security group ingress and egress rules to add to the security group created                                                                                                                                                                                                               | `any`                                                                                                                                                                         | `{}`                                                                          | no       |
| security_group_tags                     | A map of additional tags to add to the security group created                                                                                                                                                                                                                              | `map(string)`                                                                                                                                                                 | `{}`                                                                          | no       |
| security_group_use_name_prefix          | Determines whether the security group name (`security_group_name`) is used as a prefix                                                                                                                                                                                                     | `bool`                                                                                                                                                                        | `true`                                                                        | no       |
| software_update_options                 | Software update options for the domain                                                                                                                                                                                                                                                     | `any`                                                                                                                                                                         | `{"auto_software_update_enabled": true}`                                      | no       |
| tags                                    | A map of tags to add to all resources                                                                                                                                                                                                                                                      | `map(string)`                                                                                                                                                                 | `{}`                                                                          | no       |
| timeouts                                | Create and delete timeout configurations for the domain                                                                                                                                                                                                                                    | `map(string)`                                                                                                                                                                 | `{}`                                                                          | no       |
| vpc_endpoints                           | Map of VPC endpoints to create for the domain                                                                                                                                                                                                                                              | `any`                                                                                                                                                                         | `{}`                                                                          | no       |
| vpc_options                             | Configuration block for VPC related options                                                                                                                                                                                                                                                | `any`                                                                                                                                                                         | `{}`                                                                          | no       |







## ⚠️ Important Notes
- **🚨 Domain Name Constraints:** The domain name must be between 3 and 28 characters, start with a lowercase letter, and contain only lowercase letters, numbers, and hyphens. OpenSearch will reject the request if the constraints aren't met.
- **⚠️ Access Policies:** If the cluster runs in a VPC, IP-based access policies are not supported. Use Security Groups to restrict network traffic instead.
- **🚨 Service Linked Role:** A VPC deployment requires the `AWSServiceRoleForAmazonOpenSearchService` role to exist in your account. AWS creates it automatically most times, or you can use `aws_iam_service_linked_role` to ensure it exists.



---

## 🤝 Contributing
We welcome contributions! Please see our contributing guidelines for more details.

## 🆘 Support
- 📧 **Email**: info@gocloud.la

## 🧑‍💻 About
We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.
- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

## 📄 License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details. 