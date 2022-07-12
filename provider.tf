provider "aws" {
    
  region = "ap-south-1"
}

terraform {
 backend "s3" {
   bucket         = "terraform-tfstste-bucket"
   key            = "state/terraform.tfstate"
   region         = "ap-south-1"
   encrypt        = true
 }
}
