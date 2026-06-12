\# Architecture



```mermaid

flowchart LR

&#x20;   A\[EventBridge Schedule] --> B\[AWS Lambda]

&#x20;   B --> C\[S3 Bucket]

&#x20;   B --> D\[CloudWatch Logs]

&#x20;   D --> E\[CloudWatch Alarm]

&#x20;   E --> F\[SNS Email Alert]

&#x20;   G\[GitHub Actions] --> B

&#x20;   H\[Terraform] --> C

