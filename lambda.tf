resource "aws_lambda_function" "demo_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "main"
  runtime       = "provided.al2023"
  depends_on    = [
    aws_iam_role.lambda_role,
    aws_iam_role_policy.lambda_policy,
    aws_sqs_queue.demo_sqs,
    aws_sqs_queue.demo_sqs_dlq
  ]
  filename         = "/home/tech/terraformLabs/terraform_lambda_SQS/package.zip"
  source_code_hash = filebase64sha256("package.zip")

  vpc_config {
    subnet_ids         = [var.subnet_id]
    security_group_ids = [var.securitygroup_id]
  }
  environment {
    variables = {
      SQS_DLQ_NAME = var.sqs_dlq_name
      SQS_NAME     = var.sqs_queue_name
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.demo_sqs.arn
  function_name    = aws_lambda_function.demo_lambda.arn
  batch_size       = 10
}

resource "aws_lambda_event_source_mapping" "sqs_trigger_dlq" {
  event_source_arn = aws_sqs_queue.demo_sqs_dlq.arn
  function_name    = aws_lambda_function.demo_lambda.arn
  batch_size       = 10
}
