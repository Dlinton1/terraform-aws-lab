terraform {
  backend "s3" {
    bucket = "terraform-state-dlinton1-devops"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    use_lockfile = true

    encrypt = true
  }
}