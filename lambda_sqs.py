import boto3
import os

def lambda_handler(event, context):
    sqs = boto3.client('sqs')
    queue_url = os.environ["QUEUE_URL"]

    message_body = "This is a test message 1"
    sqs.send_message(
        QueueUrl=queue_url,
        MessageBody=message_body
    )

    return {
        'statusCode': 200,
        'body': 'Message sent to SQS queue.'
    }
