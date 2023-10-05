import json

def lambda_handler(event, content):
    return {
        'statusCode': 200,
        'body': json.dumps('Test DynamoDB stream'),
        'headers': {
            'Content-Type': 'application/json'
        }
    }