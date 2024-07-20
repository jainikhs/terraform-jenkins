# variables.tf
variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}

variable "sqs_queue_name" {
  description = "SQS queue name"
  type        = string
}

variable "sqs_dlq_name" {
  description = "SQS DLQ name"
  type        = string
}

variable "vpc_id" {
  default = "vpc-05dc1aa4a36d1cd71"
  type = string
}

variable "subnet_id" {
  default = "subnet-01128dc2e393fad47"
  type = string
}

variable "securitygroup_id" {
  default = "sg-02d8ee41c4645477d"
  type = string
}


# dlq sqs add in lambda
# vpc add in lambda