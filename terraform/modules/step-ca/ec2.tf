module "ec2" {
  source = "../ec2-instance"
  instance_type = "t4g.nano"
  name = "step-ca"
  subnet_id = var.subnet_id
}