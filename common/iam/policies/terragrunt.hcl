terraform {
  source = "git@github.com:adwiza/terraform-modules.git//iam?ref=v1.6.0"
}

# terraform {
#   source = "../../../../terraform-modules/iam/"
# }

prevent_destroy = false

include "remote_backend" {
  path = find_in_parent_folders()
}

inputs = {
  iam_policies = [
    {
      iam_policy_name = "consoleAdmin"
      iam_policy_json = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "admin:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        }
    ]
}
POLICY
    },
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

  ldap_groups_policy_attachments = [
    {
      group_dn = "cn=minio-group,ou=Groups,o=bytepark,c=ru,dc=bytepark,dc=ru"
      policies = ["dev_policy", "airflow_dev_policy"]
    },
    {
      group_dn = "cn=minio-admin-group,ou=Groups,o=bytepark,c=ru,dc=bytepark,dc=ru"
      policies = ["consoleAdmin"]
    }
  ]
}
