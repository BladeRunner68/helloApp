variable "env" {default = []}
variable "appName" {default = []}
variable "runtimeEngine" {default = []} 
variable "runtimeMemSize" {default = []}
variable "runTimeout" {default = []}

variable "lambda_iam_role_arn" {
  type        = string
  description = "The ARN of the Lambda IAM role"
}
