terraform {
  source = "git@github.com:adwiza/terraform-modules.git//postgres?ref=v1.1.0"
}
# terraform {
#   source = "../../../../../terraform-modules/postgres/"
# }



include "root" {
  path = find_in_parent_folders()
}

inputs = {
  
  database_name = "airflow_dev_de_db"

  roles = [
    {
      name       = "airflow_dev_de_user"
      password   = null  # This will trigger password generation
      superuser  = false
      login      = true
      replication = false
      bypass_rls = false
    }
  ]

  postgresql_host     = "localhost"
  postgresql_port     = 5432
  postgresql_username = "postgres"
  postgresql_password = "password"
  postgresql_sslmode  = "disable"
}