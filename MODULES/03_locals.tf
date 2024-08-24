
locals {  
  region_dict = {
    us-east-1      = "use1"
  }
  shortRegion = local.region_dict[data.aws_region.current.name]
}