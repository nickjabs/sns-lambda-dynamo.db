import json
import boto3

# Initialize the DynamoDB resource and specify the table name.
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('WeatherData')

def lambda_handler(event, context):
    # Parse the SNS message JSON from the event.
    sns_message = json.loads(event['Records'][0]['Sns']['Message'])

    # Store specific attributes from the SNS message in DynamoDB.
    weather_id = sns_message.get('WeatherID')
    temperature = sns_message.get('Temperature')
    humidity = sns_message.get('Humidity')

    # Ensure that required attributes are present in the SNS message.
    if weather_id is not None and temperature is not None and humidity is not None:
        # Construct the item to put in DynamoDB.
        item = {
            'WeatherID': weather_id,
            'Temperature': temperature,
            'Humidity': humidity
        }

        # Save the values to DynamoDB.
        table.put_item(Item=item)

        return {
            'statusCode': 200,
            'body': json.dumps('Success!')
        }
    else:
        return {
            'statusCode': 400,
            'body': json.dumps('Bad Request: Missing required attributes.')
        }
