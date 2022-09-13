output "app_invoke_url" {
  value = aws_apigatewayv2_stage.gw_stage.invoke_url

  description = "Use this URL for accessing the API Gateway"

}
