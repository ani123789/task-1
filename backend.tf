terraform {
  backend "s3" {
    bucket = "terraform-backend-ani123"
    key    = "codepipeline/terraform.tfstate"
    region = "eu-north-1"
  }
}
