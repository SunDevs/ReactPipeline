resource "aws_codebuild_project" "start" {
  name           = "codebuild-start-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  service_role   = aws_iam_role.codebuild.arn
  source_version = var.BITBUCKET_BRANCH
  source {
    type     = "BITBUCKET"
    location = var.BITBUCKET_REPOSITORY
    buildspec = templatefile("${path.module}/buildspec/start.yml", {
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
    buildspec = templatefile("${path.module}/buildspec/stop.yml", {
      INSTANCE_ID = basename(aws_instance.ec2.arn)
    })
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:1.0"
    type         = "LINUX_CONTAINER"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.codebuild.name
    }
  }
}
