terraform {
  backend "s3" {
    bucket         = "harjotscloud-shared-terraform-state"
    key            = "microservices-platform/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "harjotscloud-shared-terraform-locks"
    encrypt        = true
  }
}