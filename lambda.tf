resource "aws_lambda_function" "weather_alerts_processor" {
  function_name = "WeatherAlertsProcessor"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  memory_size   = 256
  timeout       = 10
  role          = aws_iam_role.lambda_execution_role.arn

  # Include your Lambda deployment package (ZIP or S3 location)
  # Here, you should specify the correct path to your Lambda function code package.
  filename = "lambda_function.zip"

  source_code_hash = filebase64("${path.module}/lambda_function.zip")
}

# Other configurations like Lambda permissions and SNS topics can remain the same.
