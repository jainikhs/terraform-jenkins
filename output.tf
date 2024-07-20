output "sqs_queue_url" {
  value = aws_sqs_queue.demo_sqs.id
}

output "sqs_dlq_url" {
  value = aws_sqs_queue.demo_sqs_dlq.id
}

output "lambda_function_name" {
  value = aws_lambda_function.demo_lambda.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.demo_lambda.arn
}