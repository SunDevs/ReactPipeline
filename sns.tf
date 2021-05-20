resource "aws_codestarnotifications_notification_rule" "notifications" {
  detail_type = "BASIC"
  event_type_ids = [
    "codepipeline-pipeline-pipeline-execution-failed",
    "codepipeline-pipeline-pipeline-execution-canceled",
    "codepipeline-pipeline-pipeline-execution-started",
    "codepipeline-pipeline-pipeline-execution-succeeded"
  ]

  name     = "${lower(var.PROJECT_NAME)}-${random_pet.value.id}-notification"
  resource = aws_codepipeline.pipeline.arn

  target {
    address = var.SNS
  }
}
