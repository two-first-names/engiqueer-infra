output "subnet_ids" {
  value = aws_subnet.subnet.*.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}