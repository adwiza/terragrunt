terraform {
  source = "../../../../terraform-modules/iam/"
}

prevent_destroy = false

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  iam_policy_name = "my_custom_policy"
  iam_policy_json = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::dev",
        "arn:aws:s3:::dev/*"
      ]
    }
  ]
}
POLICY
}
