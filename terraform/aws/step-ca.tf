module "step-ca" {
  source = "../modules/step-ca"

  subnet_id         = module.vpc.subnet_ids[0]
  availability_zone = module.vpc.availability_zones[0]
  vpc_id = module.vpc.vpc_id
}