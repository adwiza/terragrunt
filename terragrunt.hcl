locals {
  terraform_state_key = replace("${path_relative_to_include()}/terraform.tfstate", "./", "")
}

inputs = {
  terraform_state_key = local.terraform_state_key
}


# For using the remote_state templator you shoult set up these varibles AWS_ACCESS_KEY_ID и AWS_SECRET_ACCESS_KEY.
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket                             = "terragrunt"
    endpoint                           = "http://192.168.3.14:9000"
    key                                = "${local.terraform_state_key}"
    region                             = "us-east-1"
    encrypt                            = false
    skip_credentials_validation        = true
    skip_requesting_account_id         = true
    skip_metadata_api_check            = true
    skip_region_validation             = true
    skip_bucket_versioning             = true
    skip_bucket_ssencryption           = true
    skip_bucket_root_access            = true
    skip_bucket_enforced_tls           = true
    skip_bucket_public_access_blocking = true
    disable_bucket_update              = true
    skip_bucket_versioning             = true
    skip_bucket_accesslogging          = true
    disable_aws_client_checksums       = true
    force_path_style                   = true
  }
}