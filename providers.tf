terraform {
  backend "s3" {
    bucket         = var.bucket_name
    key            = var.key
    region         = "us-east-1"
    dynamodb_table = var.dynamo_table_name
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = var.profile
}

