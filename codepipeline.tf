resource "aws_codepipeline" "pipeline" {
  name     = "pipeline-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  role_arn = aws_iam_role.codepipeline.arn
  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifact.id
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      input_artifacts  = []
      output_artifacts = ["SOURCE_OUTPUT"]
      configuration = {
        ConnectionArn    = var.CODESTAR_CONNECTION_ARN
        FullRepositoryId = var.REPOSITORY_NAME
        BranchName       = var.REPOSITORY_BRANCH
      }
    }
  }
  stage {
    name = "Start"
    action {
      name             = "Start"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SOURCE_OUTPUT"]
      output_artifacts = ["START_OUTPUT"]
      version          = "1"
      configuration = {
        ProjectName = aws_codebuild_project.start.id
      }
    }
  }
  stage {
    name = "Deploy"
    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeDeploy"
      input_artifacts  = ["START_OUTPUT"]
      output_artifacts = []
      version          = "1"
      configuration = {
        ApplicationName     = "deploy-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
        DeploymentGroupName = "group-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
      }
    }
  }
  stage {
    name = "Stop"
    action {
      name             = "Stop"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["START_OUTPUT"]
      output_artifacts = []
      version          = "1"
      configuration = {
        ProjectName = aws_codebuild_project.stop.id
      }
    }
  }
}
