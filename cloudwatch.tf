resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "codebuild-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  retention_in_days = "30"
}
