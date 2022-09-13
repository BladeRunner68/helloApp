/*

providers.tf file for AWS and supporting modules

Relies on AWS access keys either in environment variables, accessible via AWS_PROFILE shell environment var or using default profile in .aws/credentials

*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }

  }
}


# Configure the AWS Provider
provider "aws" {
  region = var.region
}

