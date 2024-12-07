terraform {
  source = "../../../../terraform-modules/minio/"
}

prevent_destroy = false

include "root" {
  path = find_in_parent_folders()
}

locals {
  bucket_name = "airflow-dev" # Define your bucket name here
}

inputs = {
  bucket_name = local.bucket_name
  acl         = "private"
}
