# Create a remote backend s3 for terraform state file
terraform {
  backend "s3" {
    bucket = "amzn-s3-bucketstatefile"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}