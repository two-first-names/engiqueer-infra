module "step-ca" {
  source = "../modules/step-ca"

  subnet_id = module.vpc.subnet_ids[0]
}