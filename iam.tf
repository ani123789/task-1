# -----------------------------
# CodeBuild IAM Role + Policy
# -----------------------------
resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "codebuild_policy"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetBucketVersioning",
          "s3:ListBucket",
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetProjects",
          "codedeploy:*",
          "codepipeline:ListPipelines",
          "codepipeline:GetPipeline",
          "codepipeline:ListTagsForResource",
          "iam:GetRole",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}

# -----------------------------
# CodeDeploy IAM Role
# -----------------------------
resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codedeploy.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# -----------------------------
# CodePipeline IAM Role + Policy
# -----------------------------
resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codestar-connections:UseConnection"
        ],
        Resource = "arn:aws:codeconnections:eu-north-1:934697152100:connection/930c111b-24a6-45a8-ab3e-409d591de38b"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetBucketVersioning",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::terraform-backend-ani123",
          "arn:aws:s3:::terraform-backend-ani123/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds",
          "codebuild:BatchGetProjects",
          "codedeploy:*",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}
