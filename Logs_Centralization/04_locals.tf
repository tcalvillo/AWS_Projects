
locals {

  region_dict = {
    eu-west-1      = "ew1",
    ap-southeast-1 = "ase1",
    ap-southeast-2 = "ase2",
    us-east-1      = "ue1",
    ca-central-1   = "cc1",
    sa-east-1      = "se1",
    us-west-2      = "uw2",
    us-gov-west-1  = "ugw1",
    eu-central-1   = "ec1",   # Frankfurt
    us-gov-east-1  = "uge1"   # currently not needed but may be necessary in the future
  }

  tags = {
      "sre-appstackcode" = var.appstackcode
      "eng-projectcode" = var.projectcode
      "sre-environment" = var.aws_env
      "sec-initiator" = var.appstackcode
      "sre-bl" = var.bl
      "sre-owner"  = var.owner
  }
  shortRegion = local.region_dict[data.aws_region.current.name]
}

