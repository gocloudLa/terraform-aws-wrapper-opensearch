data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${local.common_name_prefix}"]
  }
}



data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  tags = {
    Name = "${local.common_name_prefix}-private*"
  }
}
