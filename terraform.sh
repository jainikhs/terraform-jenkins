export TF_VAR_lambda_function_name=$TF_VAR_lambda_function_name
export TF_VAR_sqs_queue_name=$TF_VAR_sqs_queue_name
export TF_VAR_sqs_dlq_name=$TF_VAR_sqs_dlq_name

terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
