provider "aws" {
  region = var.default_region
  default_tags {
    tags = local.tags
  }
  ignore_tags {
    keys = ["A", "B", "C", "D", "E", "F"]
  }
}
#-----------------------------------------------------


#-----------------------------------------------------
provider "tls" {
  proxy {
    from_env = true
  }
}
#--------------------------------------------------
