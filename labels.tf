module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  attributes  = concat(["ssm"], var.attributes)
  tags        = var.tags
}
