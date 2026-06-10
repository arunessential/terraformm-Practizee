terraform   {
    backend "s3" {
        bucket = "statebucketdeployy"
        key    = "terraform.tfstate"
        use_lockfile = true #s3 native locking foor state file to prevent concurent locking
        region = "us-east-1"
    }
}