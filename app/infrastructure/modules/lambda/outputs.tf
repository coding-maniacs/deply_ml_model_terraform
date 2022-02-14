output "lambda_invoke_arn" {
  value = aws_lambda_function.test_service_lambda_function.invoke_arn
}