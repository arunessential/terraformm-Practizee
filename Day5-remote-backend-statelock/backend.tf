terraform   {
    backend "s3" {
        bucket = "statebucketdeployy"
        key    = "terraform.tfstate"
        dynamodb_table = "arunamsterdam"
        encrypt = true
       # s3 native locking foor state file to prevent concurent locking
       # use_lockfile = true #s3 native locking foor state file to prevent concurent locking
        region = "us-east-1"
    }
}


#supports latest version >=1.10
#<1.10 we can use dynamodb for state locking as well, but sw is more efficint 
#State locking : Terraform acquires a state lock to protect the state from being written by multiple users at the same time. Please resolve the issue above and try again


#State lockfile : Terraform acquires a state lock to protect the state from being written by multiple users at the same time. Please resolve the issue above and try again0