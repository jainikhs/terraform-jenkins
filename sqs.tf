resource "aws_sqs_queue" "demo_sqs_dlq" {
  name                      = var.sqs_dlq_name
  message_retention_seconds = 1209600 # 14 days
  visibility_timeout_seconds = 50
  kms_master_key_id         = "alias/aws/sqs"
}

resource "aws_sqs_queue" "demo_sqs" {
  name                      = var.sqs_queue_name
  redrive_policy            = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.demo_sqs_dlq.arn
    maxReceiveCount     = 1
  })
  message_retention_seconds = 1209600 # 14 days
  visibility_timeout_seconds = 50
  kms_master_key_id         = "alias/aws/sqs"
}