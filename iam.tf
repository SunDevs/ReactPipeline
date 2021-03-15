########################
# SERVICE-LINKED ROLES #
########################

resource "aws_iam_role" "codebuild" {
  name = "codebuild-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
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

resource "aws_iam_role" "codedeploy" {
  name = "codedeploy-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
        Sid = ""
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role" "codepipeline" {
  name = "codepipeline-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Sid = ""
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = "ec2-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role" "ec2" {
  name = "ec2-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Sid = ""
      }
    ]
    Version = "2012-10-17"
  })
}

################################
# SERVICE-LINKED ROLE POLICIES #
################################

resource "aws_iam_role_policy" "codebuild" {
  name = "codebuild-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
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
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy.name
}

resource "aws_iam_role_policy" "codepipeline" {
  name = "codepipeline-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
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
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "ec2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.ec2.name
}
