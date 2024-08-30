data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.vpc.id

  cidr_block      = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  ipv6_cidr_block = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, count.index)

  availability_zone               = data.aws_availability_zones.available.names[count.index]
  assign_ipv6_address_on_creation = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.eigw.id
  }
}

resource "aws_route_table_association" "route_table_association" {
  count          = length(aws_subnet.subnet)
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.subnet[count.index].id
}