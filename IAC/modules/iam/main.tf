#set up assume role for Lambda

data "aws_iam_policy_document" "lambda_assume_role_policy"{
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "lambda-iam-role" {  
  name = "lambda-${var.appName}-${var.env}-role"  
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json

  tags = {
    Environment = var.env
    Application = var.appName
  }

}


resource "aws_cloudwatch_log_group" "function_log_group" {
  name = "/aws/lambda/${var.appName}-${var.env}"
  retention_in_days = var.log_retention_days 
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Environment = var.env
    Application = var.appName
  }

}

#set up Cloudwatch logging access for Lambda

resource "aws_iam_policy" "function_logging_policy" {
  name   = "function-logging-policy-${var.appName}-${var.env}"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "arn:aws:logs:*:*:*"
      }
    ]
  })
  tags = {
    Environment = var.env
    Application = var.appName
  }
}

resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  role = aws_iam_role.lambda-iam-role.id
  policy_arn = aws_iam_policy.function_logging_policy.arn
}
