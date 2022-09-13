output "app_invoke_url" {
  //value = aws_apigatewayv2_stage.gw-stage.invoke_url

  description = "Use this URL for accessing the API Gateway"

  value = module.api_gateway[0].app_invoke_url
}
