data "aws_iam_policy_document" "lambda_execution_role" {
  statement {
    principals {
      type        = "service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = [ "sts:AssumeRole" ]
  }
}

# resource "aws_iam_policy" "custom_lambda_execution_policy" {
#   name   = "custom_lambda_execution_policy"
#   path   = "/"
#   policy = data.aws_iam_policy_document.lambda_execution_role.json
# }

resource "aws_iam_role" "custom_lambda_execution_role" {
  name = "custom_lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_execution_role.json
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.custom_lambda_execution_role.arn
  handler       = "index.test"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "python3.9"

}