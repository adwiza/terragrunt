terraform {
  source = "git@github.com:adwiza/terraform-modules.git//postgres?ref=v1.1.1"
}

# terraform {
#   source = "../../../../../terraform-modules/postgres/"
# }

include "root" {
  path = find_in_parent_folders()
}

locals {
  vault_path = "secret/rds/airflow_dev_de_db/airflow_dev_de_user"
}

inputs = {
  database_name = "airflow_dev_de_db"

  vault_path = local.vault_path
  roles = [
    {
      name        = "airflow_dev_de_user"
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
