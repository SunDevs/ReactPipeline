resource "aws_codedeploy_app" "codedeploy" {
  compute_platform = "Server"
  name             = "deploy-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
}

resource "aws_codedeploy_deployment_group" "codedeploy" {
  app_name               = aws_codedeploy_app.codedeploy.name
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  deployment_group_name  = "group-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  service_role_arn       = aws_iam_role.codedeploy.arn
  ec2_tag_set {
    ec2_tag_filter {
      type  = "KEY_AND_VALUE"
      key   = "Name"
      value = "ec2-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
    }
  }
}
