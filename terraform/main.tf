terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "weather_bucket" {
  bucket = "weather-pipeline-yourname"
}

resource "aws_s3_bucket_versioning" "weather_bucket_versioning" {
  bucket = aws_s3_bucket.weather_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}