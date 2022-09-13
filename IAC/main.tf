

/*
    Modules
*/
module "iam_setup" {
  source = "./modules/iam"

  log_retention_days = var.log_retention_days
  appName            = var.appName
  env = var.env
  count              = var.run_iam ? 1 : 0

}

module "lambda_func" {
  source     = "./modules/lambda"
  depends_on = [module.iam_setup]

  lambda_iam_role_arn = module.iam_setup[0].lambda_iam_role_arn
  appName             = var.appName
  runtimeMemSize      = var.runtimeMemSize
  runTimeout = var.runTimeout
  runtimeEngine = var.runtimeEngine
  env = var.env
  count               = var.run_lambda ? 1 : 0


}

module "api_gateway" {
  source = "./modules/gateway"
  depends_on = [module.lambda_func,module.iam_setup]

  lambda_function_arn = module.lambda_func[0].lambda_function_arn
  lambda_function_name = module.lambda_func[0].lambda_function_name
  env = var.env
  appName = var.appName
  log_retention_days = var.log_retention_days
  count               = var.run_gateway ? 1 : 0

}

