data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${local.common_name_prefix}"]
  }
}



data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  tags = {
    Name = "${local.common_name_prefix}-private*"
  }
}

# data "aws_subnet" "public" {
#   for_each = toset(data.aws_vpc.vpc.public_subnet_ids)

#   id = each.value
# }

