import boto3
def lambda_handler(event, context):
    result = "hello"
    print(result)
    return {
        'statusCode' : 200,
        'body': result
    }
