# terraform {
#   source = "git@github.com:adwiza/terraform-modules.git//iam?ref=v1.5.0"
# }

terraform {
  source = "../../../../terraform-modules/iam/"
}

prevent_destroy = false

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  iam_policies = [
    {
      iam_policy_name = "dev_policy"
      iam_policy_json = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:DeleteObject"

      ],
      "Resource": [
        "arn:aws:s3:::dev/*",
        "arn:aws:s3:::dev"
      ]
    }
  ]
}
POLICY
    },
    {
      iam_policy_name = "prod_policy"
      iam_policy_json = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::prod/*",
        "arn:aws:s3:::prod"
      ]
    }
  ]
}
POLICY
    },
    {
      iam_policy_name = "airflow_dev_policy"
      iam_policy_json = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::airflow-dev/*",
        "arn:aws:s3:::airflow-dev"
      ]
    }
  ]
}
POLICY
    },
    {
      iam_policy_name = "airflow_prod_policy"
      iam_policy_json = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::airflow-prod/*",
        "arn:aws:s3:::airflow-prod"
      ]
    }
  ]
}
POLICY
    }
  ]

  # ldap_groups_policy_attachments = [
  #   {
  #     group_dn = "CN=admins,OU=Unit,DC=example,DC=com"
  #     policies = ["dev_policy", "prod_policy"]
  #   },
  #   {
  #     group_dn = "CN=developers,OU=Unit,DC=example,DC=com"
  #     policies = ["dev_policy"]
  #   }
  # ]
  non_ldap_group_policy_attachments = [
    {
      group_name = "admins"
      policies   = ["prod_policy", "airflow_prod_policy"]
    },
    {
      group_name = "developers"
      policies   = ["dev_policy", "airflow_dev_policy"]
    }
  ]
}
