output "iam_user_name" {
  value = aws_iam_user.user.name
}

output "user_access_key_id" {
  value     = aws_iam_access_key.user_key.id
  sensitive = true
}

output "user_secret_access_key" {
  value     = aws_iam_access_key.user_key.secret
  sensitive = true
}

output "console_password" {
  value     = random_password.user_password.result
  sensitive = true
}