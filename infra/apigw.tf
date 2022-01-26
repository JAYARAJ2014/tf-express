# Create a regional REST api end point named jayawsexpressapi 
resource "aws_api_gateway_rest_api" "jayawsexpressapi" {
  name = "jayawsexpressapi"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
# Create an API Resource. We are going to proxy all reqeusts to the ExpressJS application
# Hence resource name is {proxy+} (as defined by aws)

resource "aws_api_gateway_resource" "proxy_prefix" {
  parent_id   = aws_api_gateway_rest_api.jayawsexpressapi.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.jayawsexpressapi.id
  path_part   = "{proxy+}"
}

# We are passing all methods as is to the expressjs app.
resource "aws_api_gateway_method" "proxy_all_methods" {
  rest_api_id      = aws_api_gateway_rest_api.jayawsexpressapi.id
  resource_id      = aws_api_gateway_resource.proxy_prefix.id
  http_method      = "ANY"
  authorization    = "NONE"
  api_key_required = false
}

# Define an integration between lambda and api gateway

resource "aws_api_gateway_integration" "proxy_integration_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.jayawsexpressapi.id
  resource_id             = aws_api_gateway_resource.proxy_prefix.id
  http_method             = aws_api_gateway_method.proxy_all_methods.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.express-api.invoke_arn
  credentials             = aws_iam_role.apigw_role.arn
}
# Define an API Gateway Stage

resource "aws_api_gateway_stage" "jayawsexpressapi_stage" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.jayawsexpressapi.id
  deployment_id = aws_api_gateway_deployment.jayawsexpressapi_deployment.id
}
# Define the deployment 
resource "aws_api_gateway_deployment" "jayawsexpressapi_deployment" {
  rest_api_id = aws_api_gateway_rest_api.jayawsexpressapi.id
  depends_on = [
    aws_api_gateway_integration.proxy_integration_lambda
  ]
}

resource "aws_api_gateway_api_key" "express_api_key" {
  name = "dev_key"
}


