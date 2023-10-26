![Alt text](<Screenshot 2023-10-26 191858.png>)

Weather Alert System with AWS Lambda and DynamoDB

This project sets up a serverless weather alert system using AWS services like Lambda, DynamoDB, and SNS (Simple Notification Service). The system listens for weather data updates through SNS messages and stores the data in a DynamoDB database.

Components
AWS Lambda Function
The WeatherAlertsProcessor Lambda function is responsible for processing SNS messages and storing data in DynamoDB.
It is written in Python 3.8 and uses the boto3 library to interact with AWS services.

AWS DynamoDB Table
The WeatherData DynamoDB table stores weather-related data received via SNS messages.
It uses a simple schema with the "WeatherID" as the primary key for efficient data retrieval.

AWS SNS Topic
The WeatherNotification SNS topic is used for sending weather data alerts.
Subscribers, such as email addresses, can receive alerts when new data is available.

Configuration
The project is configured through Terraform, an infrastructure-as-code tool.
The .tf files define the infrastructure components, IAM roles, Lambda functions, and more.

Usage
Clone this repository.
Set up your AWS credentials and configure your environment.
Run terraform init and terraform apply to provision the infrastructure.
Deploy your Lambda function code using terraform apply.
Set up SNS subscribers to receive alerts.
Start sending weather data to the SNS topic for processing.
Contributing
Pull requests and contributions are welcome. Feel free to improve or extend the functionality of this weather alert system.