terraform {

  backend "s3" {

    bucket = "terraform-devops-state-dlinton"

    key = "dev/terraform.tfstate"

    region = "us-east-1"

    dynamodb_table = "terraform-locks"

    encrypt = true

  }

}