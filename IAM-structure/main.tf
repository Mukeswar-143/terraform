# --------------------------
# IAM User
# --------------------------
resource "aws_iam_user" "user" {
  name          = var.user_name
  force_destroy = true
  tags          = local.tags
}

# --------------------------
# Access Key for programmatic use
# --------------------------
resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

# --------------------------
# IAM Policy for EC2 + S3
# --------------------------
data "aws_iam_policy_document" "user_policy" {
  statement {
    sid    = "EC2Access"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:RebootInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "S3Access"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

resource "aws_iam_policy" "user_policy" {
  name        = "${var.project}-ec2-s3-access"
  description = "Allow user access to EC2 and ${var.bucket_name}"
  policy      = data.aws_iam_policy_document.user_policy.json
}

# --------------------------
# Attach policy to the user
# --------------------------
resource "aws_iam_user_policy_attachment" "user_attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.user_policy.arn
}

# --------------------------
# Console Login with Generated Password
# --------------------------
resource "random_password" "user_password" {
  length           = 12
  special          = true
  override_special = "!@#$%^&*"
}

resource "aws_iam_user_login_profile" "console_login" {
  user                    = aws_iam_user.user.name
  password_reset_required = true

  # optional: if you want to see the password
  # pgp_key = "keybase:your_keybase_username"
}



