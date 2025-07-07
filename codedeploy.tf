resource "aws_codedeploy_app" "codepipeline_app" {
  name             = "MyCodeDeployApp"
  compute_platform = "Server" # For EC2, or "Lambda" if using Lambda
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = aws_codedeploy_app.codepipeline_app.name
  deployment_group_name = "MyDeploymentGroup"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_style {
    deployment_option = "WITH_ROLLBACK"
    deployment_type   = "IN_PLACE"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "CodeDeployEC2"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
