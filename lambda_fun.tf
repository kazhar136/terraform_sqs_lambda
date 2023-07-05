# Define data source for creating a zip archive file

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_sqs.py"
  output_path = "${path.module}/lambda_sqs.zip"
}

# Define AWS Lambda function resource

resource "aws_lambda_function" "test_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "my_lambda_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_sqs.lambda_handler"


  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

  runtime = "python3.10"


  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.queue.id
    }
  }


}