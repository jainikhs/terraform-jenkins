# data "aws_iam_policy" "healthians_lambda_mq_policy_3" {
#   arn = "arn:aws:iam::975050280199:policy/healthians_lambda_mq_policy_3"
# }



data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "hl_lambda_role_haptik_whatsapp_sender"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "hl_lambda_policy_haptik_whatsapp_sender"
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:DescribeLogStreams",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "cloudwatch:GetMetricData",
          "logs:GetLogEvents",
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "lambda:GetFunction",
          "sqs:SendMessage",
          "lambda:UpdateFunctionCode"
        ],
        "Resource": [
          "arn:aws:logs:ap-south-1:975050280199:log-group:/aws/lambda/${var.lambda_function_name}:*",
          //"arn:aws:logs:ap-south-1:975050280199:log-group:/aws/lambda/demo_lambda:*",
          "arn:aws:logs:ap-south-1:975050280199:log-group:Expedient:*",
          "arn:aws:logs:ap-south-1:975050280199:log-group:Expedient-Lambda:*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "sqs:DeleteMessage",
          "sqs:ReceiveMessage",
          "sqs:SendMessage",
          "sqs:GetQueueAttributes",
          "lambda:GetFunction",
          "lambda:UpdateFunctionCode"
        ],
        "Resource": [
          aws_sqs_queue.demo_sqs.arn,
          aws_sqs_queue.demo_sqs_dlq.arn
          //"arn:aws:sqs:ap-south-1:975050280199:Demo_sqs",
          //"arn:aws:sqs:ap-south-1:975050280199:Demo_sqs_dlq",
          //"arn:aws:logs:ap-south-1:975050280199:log-group:*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:DescribeLogStreams",
          "logs:CreateLogGroup",
          "logs:GetLogEvents",
          "cloudwatch:GetMetricData",
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "lambda:GetFunction",
          "sqs:SendMessage",
          "lambda:UpdateFunctionCode"
        ],
        "Resource": [
          "*"
        ]
      }
    ]
  })
}
