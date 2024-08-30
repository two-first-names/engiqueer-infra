output "subnet_ids" {
  value = aws_subnet.subnet.*.id
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}