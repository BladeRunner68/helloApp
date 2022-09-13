## filename:
## author:
## purpose:
## version: 
## last updated:


data "archive_file" "python_lambda_pkg_App" {  
  type = "zip"  
  source_file = "${path.module}/code/lambda_${var.appName}.py" 
  output_path = "${path.module}/code/${var.appName}_deploy-${var.env}.zip"
}


resource "aws_lambda_function" "function_app" {
        function_name = "${var.appName}-${var.env}"
        filename      = "${path.module}/code/${var.appName}_deploy-${var.env}.zip"
        source_code_hash = "data.archive_file.python-lambda-pkg-${var.appName}-${var.env}.output_base64sha256"
        role          = var.lambda_iam_role_arn
        runtime       = var.runtimeEngine
        memory_size   = var.runtimeMemSize
        handler       = "lambda_${var.appName}.lambda_handler"
        timeout       = var.runTimeout
  tags = {
    Environment = var.env
    Application = var.appName
  }

}
