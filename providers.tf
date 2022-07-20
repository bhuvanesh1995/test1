/*terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.17.1"
    }
  }

  /*backend "s3" {
    bucket = "awsai1995"
    key    = "awsai1995/tfstate"
    region = "us-east-2"

    dynamodb_table = "awsai1995table"

  } */


provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-2"
}
