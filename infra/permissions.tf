# aws_lambda_permission.api_gw gives API Gateway permission to invoke your Lambda function.


resource "aws_lambda_permission" "allow_apigw_invoke_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.express-api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.jayawsexpressapi.execution_arn}/*/*/*"
}



resource "aws_iam_role" "apigw_role" {
  name               = "apigw_role"
  path               = "/service-role/"
  assume_role_policy = <<EOF
{
    "Version" :"2012-10-17",
    "Statement" : [
      {
      "Action" : "sts:AssumeRole",
      "Principal": {
        "Service":"apigateway.amazonaws.com"
      },
      "Effect" : "Allow"
      }
    ]
  }
EOF
}

resource "aws_iam_policy" "allow_invoke_lambda" {

  name   = "express-api-allow-invoke-lambda"
  path   = "/service-role/"
  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Effect":"Allow",
      "Action": "lambda:InvokeFunction",
      "Resource":"*"
    }
  ]
}
EOF

}

# Attach policy to the role
resource "aws_iam_role_policy_attachment" "attachment_lambda_invocation" {
  role       = aws_iam_role.apigw_role.name
  policy_arn = aws_iam_policy.allow_invoke_lambda.arn
}


resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  path               = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Effect":"Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

