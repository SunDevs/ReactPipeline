########################
# SERVICE-LINKED ROLES #
########################

resource "aws_iam_role" "codebuild" {
  name = "codebuild-${var.PROJECT_NAME}"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Sid = ""
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role" "codepipeline" {
  name = "codepipeline-${var.PROJECT_NAME}"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Sid = ""
      },
    ]
    Version = "2012-10-17"
  })
}

################################
# SERVICE-LINKED ROLE POLICIES #
################################

resource "aws_iam_role_policy" "codebuild" {
  name = "codebuild-${var.PROJECT_NAME}"
  role = aws_iam_role.codebuild.id
  policy = jsonencode({
    Statement = [
      {
        Action   = "ec2:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = ""
      },
      {
        Action   = "logs:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = ""
      },
      {
        Action   = "ssm:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = ""
      },
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = ""
      },
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy" "codepipeline" {
  name = "codepipeline-${var.PROJECT_NAME}"
  role = aws_iam_role.codepipeline.id
  policy = jsonencode({
    Statement = [
      {
        Action   = "codebuild:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = ""
      },
      {
        Action   = "codestar-connections:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = ""
      },
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = ""
      },
    ]
    Version = "2012-10-17"
  })
}
