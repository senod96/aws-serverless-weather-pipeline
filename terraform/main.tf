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

resource "aws_sns_topic" "weather_alerts" {
  name         = "weather-pipeline-alerts"
  display_name = "weather-pipeline-alerts"

  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget     = 20
        maxDelayTarget     = 20
        numRetries         = 3
        numMaxDelayRetries = 0
        numNoDelayRetries  = 0
        numMinDelayRetries = 0
        backoffFunction    = "linear"
      }
      defaultRequestPolicy = {
        headerContentType = "text/plain; charset=UTF-8"
      }
      disableSubscriptionOverrides = false
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "weather-pipeline-lambda-errors"
  alarm_description   = "Alerts when the weather Lambda function encounters errors."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 1
  period              = 300
  statistic           = "Sum"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  treat_missing_data  = "missing"

  dimensions = {
    FunctionName = "weather-pdf-downloader"
  }

  alarm_actions = [
    aws_sns_topic.weather_alerts.arn
  ]
}