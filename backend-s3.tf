terraform {
  backend "s3" {
    bucket         = "terraformstate-vprofile"
    key            = "terraform/backend"
    region         = "us-east-2"
    # dynamodb_table = "terraform-lock-table"
    encrypt        = false
  }
}
