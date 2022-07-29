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
  access_key = "AKIA4R5LVG43JVMO5Y4U"
  secret_key = "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"
  region     = "us-east-2"
}
