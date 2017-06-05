resource "aws_iam_instance_profile" "app" {
  name = "app-${var.project}-${var.environment_name}"
  role = "${aws_iam_role.app.name}"
}

resource "aws_iam_role" "app" {
  name = "app-${var.project}-${var.environment_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3_secrets_read" {
  name = "s3_secrets_read"
  role = "${aws_iam_role.app.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:ListBucket"
      ],
    "Effect": "Allow",
    "Resource": [
        "arn:aws:s3:::app-secrets",
        "arn:aws:s3:::app-secrets/*"
      ]
    }
  ]
}
EOF
}
