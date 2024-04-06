resource "aws_iam_user" "abz_user" {
  name          = var.user_name
  path          = var.user_path
  force_destroy = true

  tags = {
    "Name" = "${var.name_pref}user"
  }
}

resource "aws_iam_user_login_profile" "abz" {
  user = aws_iam_user.abz_user.name
}

resource "aws_iam_policy" "read_only_policy" {
  description = "Policy for read-only access, except S3 buckets"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "ec2:Describe*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "rds:Describe*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "cloudwatch:Get*",
        "Resource" : "*"
      }
    ]
  })

  tags = {
    "Name" = "read_only_policy"
  }
}

resource "aws_iam_user_policy_attachment" "check_right_user" {
  user       = aws_iam_user.abz_user.name
  policy_arn = aws_iam_policy.read_only_policy.arn
}