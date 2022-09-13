variable "env" {default = []}
variable "appName" {default = []}
variable "log_retention_days" {default = []}

variable "lambda_function_arn" {
  type = string
}
variable "lambda_function_name" {
  type = string
}
