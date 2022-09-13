output "lambda_function_arn" {
  value = aws_lambda_function.function_app.invoke_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.function_app.function_name
}
