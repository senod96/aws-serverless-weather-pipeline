\# Setup Guide



\## Prerequisites



\* AWS Account

\* GitHub Account

\* Terraform

\* AWS CLI

\* Git



\---



\## Clone Repository



```bash

git clone <repository-url>

cd aws-serverless-weather-pipeline

```



\---



\## Configure AWS CLI



```bash

aws configure

```



Provide:



```text

AWS Access Key ID

AWS Secret Access Key

Region: us-east-1

```



\---



\## Initialize Terraform



```bash

cd terraform

terraform init

```



\---



\## Review Infrastructure



```bash

terraform plan

```



\---



\## Deploy Infrastructure



```bash

terraform apply

```



\---



\## Configure GitHub Secrets



Repository → Settings → Secrets and Variables → Actions



Add:



```text

AWS\_ACCESS\_KEY\_ID

AWS\_SECRET\_ACCESS\_KEY

AWS\_REGION

```



\---



\## Deploy Lambda



Push code to GitHub:



```bash

git add .

git commit -m "Deploy update"

git push

```



GitHub Actions automatically updates AWS Lambda.



\---



\## Verify Operation



1\. Check EventBridge Scheduler

2\. Check Lambda executions

3\. Check S3 bucket contents

4\. Check CloudWatch logs

5\. Verify SNS email notifications



\---



\## Expected S3 Structure



```text

raw/

└── YYYY-MM-DD/

&#x20;   └── weather-report.pdf

```



