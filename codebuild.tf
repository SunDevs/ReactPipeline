resource "aws_codebuild_project" "start" {
  name         = "codebuild-start-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  service_role = aws_iam_role.codebuild.arn
  source {
    type = "NO_SOURCE"
    buildspec = templatefile("${path.module}/codebuild/start/buildspec.yml", {
      INSTANCE_ID = basename(aws_instance.ec2.arn)
    })
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:1.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "APPSPEC_YML"
      value = filebase64("${path.module}/codedeploy/appspec.yml")
    }
    environment_variable {
      name  = "SCRIPT_PS1"
      value = filebase64("${path.module}/codedeploy/script.ps1")
    }
    dynamic "environment_variable" {
      for_each = var.DOTENV != null ? [var.DOTENV] : []
      content {
        name  = "DOTENV"
        value = base64encode(var.DOTENV)
      }
    }
    dynamic "environment_variable" {
      for_each = var.GIT_PRIVATE_KEY != null ? [var.GIT_PRIVATE_KEY] : []
      content {
        name  = "GIT_PRIVATE_KEY"
        value = base64encode(var.GIT_PRIVATE_KEY)
      }
    }
  }
  artifacts {
    type      = "S3"
    packaging = "ZIP"
    name      = "START_OUTPUT"
    location  = aws_s3_bucket.artifact.id
  }
  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.codebuild.name
    }
  }
}

resource "aws_codebuild_project" "stop" {
  name         = "codebuild-stop-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  service_role = aws_iam_role.codebuild.arn
  source {
    type = "NO_SOURCE"
    buildspec = templatefile("${path.module}/codebuild/stop/buildspec.yml", {
      INSTANCE_ID = basename(aws_instance.ec2.arn)
    })
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:1.0"
    type         = "LINUX_CONTAINER"
  }
  artifacts {
    type      = "S3"
    packaging = "ZIP"
    name      = "STOP_OUTPUT"
    location  = aws_s3_bucket.artifact.id
  }
  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.codebuild.name
    }
  }
}
