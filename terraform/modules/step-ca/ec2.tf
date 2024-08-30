module "ec2" {
  source        = "../ec2-instance"
  instance_type = "t4g.nano"
  name          = "ca.engiqueer.net"
  subnet_id     = var.subnet_id
}

resource "aws_ebs_volume" "step-ca" {
  availability_zone = var.availability_zone
  size              = 8
  type              = "gp3"
  encrypted         = true
}

resource "aws_volume_attachment" "step-ca" {
  device_name = "/dev/sdf"
  instance_id = module.ec2.instance_id
  volume_id   = aws_ebs_volume.step-ca.id
}