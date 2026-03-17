module "opensearch_collection_public" {
  source = "terraform-aws-modules/opensearch/aws//modules/collection"

  name             = "${local.name}-public"
  description      = "Example public OpenSearch Serverless collection"
  type             = "SEARCH"
  standby_replicas = "DISABLED"

  create_access_policy  = true
  create_network_policy = true

  tags = local.tags
}

module "opensearch_collection_private" {
  source = "terraform-aws-modules/opensearch/aws//modules/collection"

  name        = "${local.name}-private"
  description = "Example private OpenSearch Serverless collection"
  type        = "SEARCH"

  create_access_policy  = true
  create_network_policy = true
  network_policy = {
    AllowFromPublic = false
    SourceVPCEs = [
      aws_opensearchserverless_vpc_endpoint.example.id
    ]
  }

  tags = local.tags
}

module "opensearch_collection_disabled" {
  source = "terraform-aws-modules/opensearch/aws//modules/collection"

  create = false
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_opensearchserverless_vpc_endpoint" "example" {
  name       = local.name
  subnet_ids = data.aws_subnets.private.ids
  vpc_id     = data.aws_vpc.vpc.id
}
