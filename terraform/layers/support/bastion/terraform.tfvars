aws_profile = "dare"

availability_zone = "eu-west-1a"

region = "eu-west-1"

state_bucket = "cdh-infra"

state_file = "infrastructure/cdh5_state.state"

ami_id = "ami-12291974"

instance_type = "t2.micro"

key_name = "cluster_key"

availability_zone = "eu-west-1a"

aws_profile = "dare"

volume_size = 30

instance_count = 1

public_key_path = "/Users/dare.olufunmilayo/.ssh/id_rsa.pub"

terragrunt = {
  # Configure Terragrunt to use DynamoDB for locking
  lock {
    backend = "dynamodb"

    config {
      state_file_id = "infra-dev"
    }
  }

  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"

    config {
      encrypt = "false"
      bucket  = "cdh-infra"
      key     = "infrastructure/cdh5_state.state"
      region  = "eu-west-1"
    }
  }
}
