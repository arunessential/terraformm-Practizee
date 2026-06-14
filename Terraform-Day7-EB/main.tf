# Create aws iam role for lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role_V2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AWSLambdaBasicExecutionRole policy to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create a Lambda function
resource "aws_lambda_function" "hello_world" {
  function_name = "HelloWorldFunction"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 900
  memory_size   = 128
  filename      = "lambda_function.zip"

# source code hash
  source_code_hash = filebase64sha256("lambda_function.zip")

    # Without source_code_hash, terrafrom might not detect changes in the code and won't update the function
    # This hash is a checksum that triggers a deployment when the code changes
}

# Create EventBridge rule (schedule) 
resource "aws_cloudwatch_event_rule" "every_5_minutes" {
  name                = "every-5-minutes"
  description         = "Trigger Lambda every 5 minutes"
#  schedule_expression = "rate(5 minutes)"
    schedule_expression = "cron(0/5 * * * ? *)" # Every 5 minutes

}

# Add the Lambda target for schedule to invoke the lambda function
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.every_5_minutes.name
  target_id = "HelloWorldFunction"
  arn       = aws_lambda_function.hello_world.arn
}

# Allow Eventbridge to invoke the Lambda function
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_5_minutes.arn
}