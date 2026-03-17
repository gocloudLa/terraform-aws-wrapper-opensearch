# Complete OpenSearch Domain Example 🚀

This example demonstrates the complete configuration of an Amazon OpenSearch Service Domain using Terraform.

## 🔧 What's Included

### Analysis of Terraform Configuration

#### Main Purpose
The main purpose is to showcase how to deploy a fully configured OpenSearch cluster inside a VPC with dedicated masters, auto-tune, fine-grained access control, and other production-ready settings.

#### Key Features Demonstrated
- **Cluster Configuration**: provisions an OpenSearch cluster with both dedicated master nodes (`c6g.large.search`) and data nodes (`r6g.large.search`), spanning 3 availability zones for high availability.
- **VPC and Security**: Deploys the cluster completely within private subnets of a VPC, managing ingress rules via attached Security Groups.
- **Fine-Grained Access Control**: Configures advanced security options, including an internal user database and a master user configuration.
- **Encryption & EBS Configuration**: Enables data encryption at rest and node-to-node encryption, along with provisioning `gp3` EBS volumes for storage.
- **Maintenance & Auto-Tune**: Sets up Auto-Tune for performance optimization and customizes the cluster's maintenance windows and software update policies.

## 🚀 Quick Start

```bash
terraform init
terraform plan
terraform apply
```

## 🔒 Security Notes

⚠️ **Production Considerations**: 
- This example may include configurations that are not suitable for production environments
- Review and customize security settings, access controls, and resource configurations
- Ensure compliance with your organization's security policies
- Consider implementing proper monitoring, logging, and backup strategies

## 📖 Documentation

For detailed module documentation and additional examples, see the main [README.md](../../README.md) file. 