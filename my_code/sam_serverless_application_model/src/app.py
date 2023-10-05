import json
import os
import uuid 
import boto3

region_name = os.environ['REGION_NAME']
dynamodb = boto3.client('dynamodb', region_name=region_name)
table_name = os.environ['TABLE_NAME']

def lambda_handler(event, content):
    random = uuid.uuid4().hex[:6].upper()
    print('random string:', random)

    put_item_result = dynamodb.put_item(TableName=table_name,
        Item={
        "user_id": {"S": str(random)},
        "user_name": {"S": "_" . join(['duong', str(random)])},
        },
    )

    print('put_item_result999:', put_item_result)

    scan_result = dynamodb.scan(TableName=table_name)

    return {
        'statusCode': 200,
        'body': json.dumps(scan_result),
        'headers': {
            'Content-Type': 'application/json'
        }
    }