resource "aws_vpc" "this" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "10.0.0.0/16"
}