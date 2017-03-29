aws_profile = "dare"

availability_zone = "eu-west-1a"

region = "eu-west-1"

bucket_name = "cdh5"

terragrunt = {
  # Configure Terragrunt to use DynamoDB for locking
  lock {
    backend = "dynamodb"

    config {
      state_file_id = "infra-dev"
    }
  }
}
