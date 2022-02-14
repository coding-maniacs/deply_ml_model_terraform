terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket = "dev-terraform-state-bucket"
    key    = "test_service_dev"
  }
}

provider "aws" {
  region  = "eu-central-1"
}

module "lambda" {
  source = "../../modules/lambda"
  environment = var.environment
}

module "apigw" {
  source = "../../modules/api_gateway"
  environment = var.environment
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
}