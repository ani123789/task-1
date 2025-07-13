# Test commit to trigger GitHub Actions


provider "aws" {
  region = var.aws_region
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "codepipeline-artifact-${random_id.bucket_id.hex}"

  tags = {
    Name        = "CodePipeline Artifact Bucket"
    Environment = "Dev"
  }
}
