resource "aws_dynamodb_table" "weather_data" {
  name           = "WeatherData"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "WeatherID"
  attribute {
    name = "WeatherID"
    type = "S"
  }
  
}
