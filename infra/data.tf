data "archive_file" "lambda_express_api" {
  type = "zip"
  # path.module is the filesystem path of the module where the expression is placed.
  source_dir  = "${path.module}/../express-api"
  output_path = "${path.module}/../express-api.zip"
}
