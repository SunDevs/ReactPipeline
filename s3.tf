resource "aws_s3_bucket" "artifact" {
  bucket_prefix = "s3-${lower(var.PROJECT_NAME)}-${random_pet.value.id}-"
  force_destroy = true
}
