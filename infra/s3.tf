resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = var.lambda_bucket_name #  NOTE: The bucket name cannot contain underscores
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_object" "lambda_express_api" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "express-api"
  source = data.archive_file.lambda_express_api.output_path
  # filemd5 is a variant of md5 that hashes the contents of a given file rather than a literal string.
  etag = filemd5(data.archive_file.lambda_express_api.output_path)
}
