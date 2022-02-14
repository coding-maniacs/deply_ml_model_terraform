resource "aws_iam_role" "test_service_lambda_role" {
  name = "${var.environment}-test_service_lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_service_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_ecr_repository" "test_service_ecr_repo" {
  name                 = "${var.environment}-test_service_ecr_repo"
  image_tag_mutability = "MUTABLE"
}

resource "aws_lambda_function" "test_service_lambda_function" {
  function_name = "${var.environment}-test_service_lambda"
  role          = aws_iam_role.test_service_lambda_role.arn
  image_uri = "${aws_ecr_repository.test_service_ecr_repo.repository_url}:latest"
  package_type = "Image"
  timeout = 60
}
