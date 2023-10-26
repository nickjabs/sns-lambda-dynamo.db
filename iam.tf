# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  # Define the assumed role policy for Lambda
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  # Attach a basic execution policy for Lambda to the role
  inline_policy {
    name = "LambdaBasicExecutionAttachment"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Action   = "sts:AssumeRole",
          Effect   = "Allow",
          Resource = "*"
        }
      ]
    })
  }
}

# Attach the IAM policy for DynamoDB to the Lambda execution role
resource "aws_iam_policy_attachment" "lambda_dynamodb_policy_attachment" {
  name       = "LambdaDynamoDBPolicyAttachment"
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
  roles      = [aws_iam_role.lambda_execution_role.name]
}

# Output the ARN of the IAM role for use in Lambda function configuration
output "lambda_execution_role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}

# IAM policy to allow Lambda to interact with DynamoDB
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "LambdaDynamoDBPolicy"
  description = "IAM policy to allow Lambda to interact with DynamoDB"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.weather_data.arn,
      },
    ],
  })
}

# Lambda's permission to be invoked by SNS
resource "aws_lambda_permission" "sns_invoke_permission" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.weather_alerts_processor.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.snstopic.arn
}
