#aws_cloudwatch_log_group.hello_world 
/*defines a log group to store log messages from your Lambda function for 30 days. 
By convention, Lambda stores logs in a group with the name /aws/lambda/<Function Name>.*/

resource "aws_cloudwatch_log_group" "lambda_log_express_api" {
  name              = "/aws/lambda/${aws_lambda_function.express-api.function_name}"
  retention_in_days = 30
}




/**
aws_cloudwatch_log_group.api_gw defines a log group to store access logs for the aws_apigatewayv2_stage.lambda 
API Gateway stage.
**/
resource "aws_cloudwatch_log_group" "apigw_log_express_api" {
  name = "/aws/api_gw/${aws_api_gateway_rest_api.jayawsexpressapi.name}"

  retention_in_days = 30
}
