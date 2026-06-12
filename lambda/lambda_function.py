import boto3
import os
import urllib.request
from datetime import datetime, timezone

s3 = boto3.client("s3")

PDF_URL = "https://meteo.gov.lk/images/wrf/24hourperiod.pdf"

def lambda_handler(event, context):
    bucket = os.environ["BUCKET_NAME"]

    today = datetime.now(timezone.utc).strftime("%Y-%m-%d")

    file_key = f"raw/{today}/weather-report.pdf"

    with urllib.request.urlopen(PDF_URL, timeout=30) as response:
        pdf_data = response.read()

    s3.put_object(
        Bucket=bucket,
        Key=file_key,
        Body=pdf_data,
        ContentType="application/pdf"
    )

    return {
        "statusCode": 200,
        "message": "Weather PDF uploaded successfully",
        "s3_key": file_key
    }
