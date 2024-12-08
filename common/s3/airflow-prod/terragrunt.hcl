terraform {
  source = "git@github.com:adwiza/terraform-modules.git//minio?ref=v1.5.0"
}

# terraform {
#   source = "../../../../terraform-modules/minio/"
# }

prevent_destroy = false

include "root" {
  path = find_in_parent_folders()
}

locals {
  bucket_name = "airflow-prod"
}

inputs = {
  bucket_name = local.bucket_name
  acl         = "private"
}
