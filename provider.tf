# bootstrap-backend.tf

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_backend" {
  bucket = "terraformstate-vprofile"
  # versioning {
  #   enabled = true
  # }
  lifecycle {
    prevent_destroy = true
  }
}

# Optional: create an empty folder (prefix) by uploading a placeholder
resource "aws_s3_object" "terraform_folder" {
  bucket = aws_s3_bucket.terraform_backend.bucket
  key    = "terraform/"
  content = ""
}

# resource "aws_dynamodb_table" "terraform_lock" {
#   name           = "terraform-lock-table"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
