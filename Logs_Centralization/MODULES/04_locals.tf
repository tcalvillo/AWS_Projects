
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
    eu-central-1   = "ec1"
  }
  shortRegion = local.region_dict[data.aws_region.current.name]
}