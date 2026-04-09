
module "wrapper_opensearch" {
  source = "../.."

  metadata = local.metadata

  opensearch_parameters = {
    example = {

      # engine_version = "OpenSearch_2.19"
      # domain_name = local.common_name

      # vpc_options = {
      #   subnet_ids = data.aws_subnets.this.ids
      # }

      ## Cluster Definition
      cluster_config = {
        # Master Nodes, you can use either 3 or 5 master nodes
        dedicated_master_enabled = false
        dedicated_master_count   = 3
        dedicated_master_type    = "t3.small.search"

        # Data Nodes
        instance_count = 3
        instance_type  = "t3.small.search"

        # Coordinator Nodes, requiered when requiring a distribution and query managment (more than 10 data nodes)
        node_options = {
          coordinator = {
            node_config = {
              enabled = false
              # count   = 1 # Must be 1 at least
              # type    = "t3.small.search"
            }
          }
        }

        zone_awareness_enabled = true
        zone_awareness_config = {
          availability_zone_count = 3
        }
      }

      ## EBS Options
      ebs_options = {
        ebs_enabled = true
        iops        = 3000
        throughput  = 125
        volume_type = "gp3"
        volume_size = 30
      }

      # Auto-Tune Options (only available for instance types outisde of t3 family)
      auto_tune_options = {
        desired_state = "DISABLED"
        # maintenance_schedule = [
        #   {
        #     start_at                       = "2028-05-13T07:44:12Z"
        #     cron_expression_for_recurrence = "cron(0 0 ? * 1 *)"
        #     duration = {
        #       value = "2"
        #       unit  = "HOURS"
        #     }
        #   }
        # ]
        rollback_on_disable = "NO_ROLLBACK"
      }

      ## Advanced Options
      # advanced_options = {
      #   "override_main_response_version"         = "true"
      #   "rest.action.multi.allow_explicit_index" = "true"
      # }

      advanced_security_options = {
        enabled                = true
        anonymous_auth_enabled = true
        # internal_user_database_enabled = true

        # master_user_options = {
        #   master_user_name     = "example"
        #   master_user_password = "Barbarbarbar1!"
        # }
      }

      # log_publishing_options = [
      #   { log_type = "INDEX_SLOW_LOGS" },
      #   { log_type = "SEARCH_SLOW_LOGS" },
      #   { log_type = "ES_APPLICATION_LOGS" }
      # ]

      software_update_options = {
        auto_software_update_enabled = true
      }

      # VPC endpoint
      vpc_endpoints = {
        one = {
          subnet_ids = data.aws_subnets.this.ids
        }
      }

      # Security Group rule example
      security_group_rules = {
        ingress_443 = {
          type        = "ingress"
          description = "HTTPS access from VPC"
          from_port   = 443
          to_port     = 443
          ip_protocol = "tcp"
          cidr_ipv4   = data.aws_vpc.this.cidr_block
        }
      }

      # Access policy
      access_policy_statements = [
        {
          effect = "Allow"

          principals = [{
            type        = "*"
            identifiers = ["*"]
          }]

          actions = ["es:*"]
        }
      ]
    }
  }
}
