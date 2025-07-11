# -----------------------------
# CodeBuild IAM Role
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

resource "aws_iam_policy" "codebuild_policy" {
  name        = "codebuild-policy"
  description = "Policy for CodeBuild to run Terraform"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:*",
          "s3:*",
          "codebuild:*",
          "codedeploy:*",
          "codepipeline:*",
          "sts:AssumeRole",
          "iam:GetRole",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",         # <-- Added!
          "iam:GetRolePolicy",            # <-- Added!
          "iam:ListAttachedRolePolicies",
          "iam:ListRolePolicies",
          "codedeploy:ListTagsForResource",
          "s3:GetBucketPolicy"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "codebuild_policy_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
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
# CodePipeline IAM Role
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
  role = aws_iam_role.codepipeline_role.name

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
          "${aws_s3_bucket.artifact_bucket.arn}",
          "${aws_s3_bucket.artifact_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds",
          "codebuild:BatchGetProjects",
          "codedeploy:*"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = [
          aws_iam_role.codebuild_role.arn,
          aws_iam_role.codedeploy_role.arn
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_role_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}
