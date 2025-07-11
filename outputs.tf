output "pipeline_name" {
  value = aws_codepipeline.codepipeline.name
}

output "artifact_bucket_name" {
  value = aws_s3_bucket.artifact_bucket.bucket
}
