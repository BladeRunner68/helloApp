## filename:
## author:
## purpose:
## version: 
## last updated:

#### eventbridge triggering - only if needed

##cw/eventbridge trigger:

resource "aws_cloudwatch_event_rule" "run-lambda-helloApp" {
  name                  = "run-lambda-helloApp"
  description           = "Schedule lambda helloApp function"
  schedule_expression   = "rate(2 minutes)"
}

### cw/eventbridge target:
resource "aws_lambda_permission" "allow-cloudwatch-helloApp" {
    #statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.function-helloApp.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.run-lambda-helloApp.arn
}

resource "aws_cloudwatch_event_target" "cw-target-helloApp" {
  target_id = "cw-target-helloApp"
  rule      = aws_cloudwatch_event_rule.run-lambda-helloApp.name
  arn       = aws_lambda_function.function-helloApp.arn
}
