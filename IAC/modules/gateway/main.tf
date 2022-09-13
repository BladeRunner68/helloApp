

resource "aws_apigatewayv2_api" "api_http_gw" {
  name          = "${var.appName}-${var.env}-api_http_gw"
  protocol_type = "HTTP"
  tags = {
    Environment = var.env
    Application = var.appName
  }

}

resource "aws_cloudwatch_log_group" "api_gw_log" {
  name = "/aws/api_gw/${var.appName}-${var.env}"

  retention_in_days = var.log_retention_days

  tags = {
    Environment = var.env
    Application = var.appName
  }

}

resource "aws_apigatewayv2_stage" "gw_stage" {
  api_id = aws_apigatewayv2_api.api_http_gw.id
  name = "${var.env}"
  auto_deploy = true

 access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw_log.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
  depends_on = [aws_cloudwatch_log_group.api_gw_log]
  tags = {
    Environment = var.env
    Application = var.appName
  }

}


resource "aws_apigatewayv2_integration" "api_http_gw_int" {
  api_id           = aws_apigatewayv2_api.api_http_gw.id
  integration_type = "AWS_PROXY"
  connection_type           = "INTERNET"
  description               = "${var.appName} int"
  integration_method        = "POST"
  integration_uri           = "${var.lambda_function_arn}"

}

resource "aws_apigatewayv2_route" "gw_route" {
  api_id    = aws_apigatewayv2_api.api_http_gw.id
  //route_key = "GET /${var.appName}"
  route_key = "$default"
  authorization_type = "AWS_IAM"
  target = "integrations/${aws_apigatewayv2_integration.api_http_gw_int.id}"
}

/*resource "aws_apigatewayv2_deployment" "Deploy" {
  api_id      = aws_apigatewayv2_api.api_http_gw.id
  description = "xxx deployment1"
  triggers = {
    redeployment = sha1(join(",", tolist([
      jsonencode(aws_apigatewayv2_integration.api_http_gw_int),
      jsonencode(aws_apigatewayv2_route.gw-route),
    ])))
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_apigatewayv2_route.gw-route
  ]
  tags = {
    Environment = var.env
    Application = var.appName
  }

}
*/





resource "aws_lambda_permission" "gw_allow" {
  statement_id  = "allow_apigw_invoke-${var.appName}-${var.env}"
  function_name = var.lambda_function_name
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_stage.gw_stage.execution_arn}/${aws_apigatewayv2_route.gw_route.route_key}"
}

