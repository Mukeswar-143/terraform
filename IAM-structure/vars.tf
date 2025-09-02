variable "region" {
  default = "eu-north-1"
}

variable "project" {
  default = "demo"
}

variable "user_name" {
  default = "dev"
}

variable "bucket_name" {
  description = "S3 bucket name to grant user access"
  type        = string
  default     = "my-private-bucket-987ty"
}
