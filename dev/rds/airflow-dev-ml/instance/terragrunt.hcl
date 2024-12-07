terraform {
  source = "git@github.com:adwiza/terraform-modules.git//postgres?ref=v1.4.0"
}

# terraform {
#   source = "../../../../../terraform-modules/postgres/"
# }

prevent_destroy = false

include "root" {
  path = find_in_parent_folders()
}

locals {
  database_name = "airflow_dev_ml_db"
  env           = split("/", path_relative_to_include())[0]
  vault_path    = "secret/${local.env}/rds/${local.database_name}"
  username      = "airflow_dev_ml_user"
  dialect       = "postgres"
}

inputs = {
  database_name = local.database_name
  vault_path    = local.vault_path
  dialect       = local.dialect

  roles = [
    {
      name        = local.username
      password    = null
      superuser   = false
      login       = true
      replication = false
      bypass_rls  = false
    }

  ]

  postgresql_host          = "localhost"
  postgresql_port          = 5432
  postgresql_root_username = "postgres"
  postgresql_sslmode       = "disable"
  postgresql_root_password = get_env("POSTGRESQL_ROOT_PASSWORD")
}
