# Output value definitions
output "module_path" {
  description = "path of current module. Useful for local."
  value       = path.module
}

output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."

  value = aws_s3_bucket.lambda_bucket.id
}


output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.express-api.function_name
}


output "base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_api_gateway_stage.jayawsexpressapi_stage.invoke_url
}
