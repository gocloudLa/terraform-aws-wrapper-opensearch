module "opensearch" {
  for_each = var.opensearch_parameters
  source   = "terraform-aws-modules/opensearch/aws"
  version  = "2.6.0"


  access_policies                         = try(each.value.access_policies, var.opensearch_defaults.access_policies, null)
  access_policy_override_policy_documents = try(each.value.access_policy_override_policy_documents, var.opensearch_defaults.access_policy_override_policy_documents, [])
  access_policy_source_policy_documents   = try(each.value.access_policy_source_policy_documents, var.opensearch_defaults.access_policy_source_policy_documents, [])
  access_policy_statements                = try(each.value.access_policy_statements, var.opensearch_defaults.access_policy_statements, {})
  advanced_options                        = try(each.value.advanced_options, var.opensearch_defaults.advanced_options, {})
  advanced_security_options               = try(each.value.advanced_security_options, var.opensearch_defaults.advanced_security_options, { "anonymous_auth_enabled" : false, "enabled" : true })
  aiml_options                            = try(each.value.aiml_options, var.opensearch_defaults.aiml_options, null)
  auto_tune_options = try(each.value.auto_tune_options, var.opensearch_defaults.auto_tune_options, {
    "desired_state" : "ENABLED",
    "rollback_on_disable" : "NO_ROLLBACK"
  })
  cloudwatch_log_group_class             = try(each.value.cloudwatch_log_group_class, var.opensearch_defaults.cloudwatch_log_group_class, null)
  cloudwatch_log_group_kms_key_id        = try(each.value.cloudwatch_log_group_kms_key_id, var.opensearch_defaults.cloudwatch_log_group_kms_key_id, null)
  cloudwatch_log_group_retention_in_days = try(each.value.cloudwatch_log_group_retention_in_days, var.opensearch_defaults.cloudwatch_log_group_retention_in_days, 60)
  cloudwatch_log_group_skip_destroy      = try(each.value.cloudwatch_log_group_skip_destroy, var.opensearch_defaults.cloudwatch_log_group_skip_destroy, null)
  cloudwatch_log_resource_policy_name    = try(each.value.cloudwatch_log_resource_policy_name, var.opensearch_defaults.cloudwatch_log_resource_policy_name, null)
  cluster_config = try(each.value.cluster_config, var.opensearch_defaults.cluster_config, {
    "dedicated_master_enabled" : true
  })
  cognito_options                       = try(each.value.cognito_options, var.opensearch_defaults.cognito_options, {})
  create                                = try(each.value.create, var.opensearch_defaults.create, true)
  create_access_policy                  = try(each.value.create_access_policy, var.opensearch_defaults.create_access_policy, true)
  create_cloudwatch_log_groups          = try(each.value.create_cloudwatch_log_groups, var.opensearch_defaults.create_cloudwatch_log_groups, true)
  create_cloudwatch_log_resource_policy = try(each.value.create_cloudwatch_log_resource_policy, var.opensearch_defaults.create_cloudwatch_log_resource_policy, true)
  create_saml_options                   = try(each.value.create_saml_options, var.opensearch_defaults.create_saml_options, false)
  create_security_group                 = try(each.value.create_security_group, var.opensearch_defaults.create_security_group, false)
  domain_endpoint_options = try(each.value.domain_endpoint_options, var.opensearch_defaults.domain_endpoint_options, {
    "enforce_https" : true,
    "tls_security_policy" : "Policy-Min-TLS-1-2-2019-07"
  })
  domain_name = try(each.value.domain_name, var.opensearch_defaults.domain_name, local.common_name)
  ebs_options = try(each.value.ebs_options, var.opensearch_defaults.ebs_options, {
    "ebs_enabled" : true,
    "volume_size" : 64,
    "volume_type" : "gp3"
  })
  enable_access_policy = try(each.value.enable_access_policy, var.opensearch_defaults.enable_access_policy, true)
  encrypt_at_rest = try(each.value.encrypt_at_rest, var.opensearch_defaults.encrypt_at_rest, {
    "enabled" : true
  })
  engine_version          = try(each.value.engine_version, var.opensearch_defaults.engine_version, null)
  identity_center_options = try(each.value.identity_center_options, var.opensearch_defaults.identity_center_options, null)
  ip_address_type         = try(each.value.ip_address_type, var.opensearch_defaults.ip_address_type, "ipv4")
  log_publishing_options = try(each.value.log_publishing_options, var.opensearch_defaults.log_publishing_options, [
    {
      "log_type" : "INDEX_SLOW_LOGS"
    },
    {
      "log_type" : "SEARCH_SLOW_LOGS"
    }
  ])
  node_to_node_encryption = try(each.value.node_to_node_encryption, var.opensearch_defaults.node_to_node_encryption, {
    "enabled" : true
  })
  off_peak_window_options = try(each.value.off_peak_window_options, var.opensearch_defaults.off_peak_window_options, {
    "enabled" : true,
    "off_peak_window" : {
      "hours" : 7
    }
  })
  outbound_connections           = try(each.value.outbound_connections, var.opensearch_defaults.outbound_connections, {})
  package_associations           = try(each.value.package_associations, var.opensearch_defaults.package_associations, {})
  region                         = try(each.value.region, var.opensearch_defaults.region, null)
  saml_options                   = try(each.value.saml_options, var.opensearch_defaults.saml_options, {})
  security_group_description     = try(each.value.security_group_description, var.opensearch_defaults.security_group_description, null)
  security_group_name            = try(each.value.security_group_name, var.opensearch_defaults.security_group_name, null)
  security_group_rules           = try(each.value.security_group_rules, var.opensearch_defaults.security_group_rules, {})
  security_group_tags            = try(each.value.security_group_tags, var.opensearch_defaults.security_group_tags, {})
  security_group_use_name_prefix = try(each.value.security_group_use_name_prefix, var.opensearch_defaults.security_group_use_name_prefix, true)
  software_update_options = try(each.value.software_update_options, var.opensearch_defaults.software_update_options, {
    "auto_software_update_enabled" : true
  })
  tags          = merge(local.common_tags, try(each.value.tags, var.opensearch_defaults.tags, null))
  timeouts      = try(each.value.timeouts, var.opensearch_defaults.timeouts, {})
  vpc_endpoints = try(each.value.vpc_endpoints, var.opensearch_defaults.vpc_endpoints, {})
  # vpc_options   = try(each.value.vpc_options, var.opensearch_defaults.vpc_options, {})
  vpc_options = {
    subnet_ids         = try(each.value.subnet_ids, var.opensearch_defaults.subnet_ids, data.aws_subnets.this[each.key].ids)
    security_group_ids = concat(try(each.value.security_group_create, true) ? [module.security_group_opensearch[each.key].security_group_id] : [], try(each.value.security_groups_ids, []))
  }

}
