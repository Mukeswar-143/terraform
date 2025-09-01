resource "aws_s3_bucket" "my_bucket" {
  bucket = "mukeswar-s3bucket-qwwwwgegf-45342" # must be globally unique
  acl    = "private"
  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}