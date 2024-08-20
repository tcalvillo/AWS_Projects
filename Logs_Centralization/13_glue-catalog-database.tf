resource "aws_glue_catalog_database" "glue-catalog-database" {
  #count = local.is_gov_resolved ? 1 : 0
  count = var.is_gov ? 1 : 0
  name = "gluecatalog-${var.bl}-${var.shortEnv}-${var.default_region}-${var.appstackcode}-catalog-database-ec2logs-${count.index}"
}