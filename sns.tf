# sns.tf
resource "aws_sns_topic" "snstopic" {
  name         = "WeatherNotification"
  display_name = "WeatherNotification"
  tags = {
    "Name" = "WeatherNotification"
  }
}

resource "aws_sns_topic_subscription" "snstopicsubscription1" {
  topic_arn = aws_sns_topic.snstopic.arn
  protocol  = "email"
  endpoint  = var.email_address_1
}

resource "aws_sns_topic_subscription" "snstopicsubscription2" {
  topic_arn = aws_sns_topic.snstopic.arn
  protocol  = "email"
  endpoint  = var.email_address_2
}


output "snsarn" {
  description = "SNS alerting topic ARN"
  value       = aws_sns_topic.snstopic.arn
}
