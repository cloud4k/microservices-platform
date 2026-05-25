terraform {
  backend "s3" {
    bucket         = "microservices-platform-terraform-state-643025069654"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "microservices-platform-terraform-locks"
    encrypt        = true
  }
}