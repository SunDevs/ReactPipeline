variable "PROJECT_NAME" {
  type = string
  validation {
    condition     = length(regexall(" +", var.PROJECT_NAME)) == 0
    error_message = "The PROJECT_NAME value must not contains whitespaces."
  }
}

variable "VPC_ID" {
  type = string
  validation {
    condition     = length(var.VPC_ID) > 4 && substr(var.VPC_ID, 0, 4) == "vpc-"
    error_message = "The VPC_ID value must be a valid vpc identifier, starting with \"vpc-\"."
  }
}

variable "SUBNET_ID" {
  type = string
  validation {
    condition     = length(var.SUBNET_ID) > 7 && substr(var.SUBNET_ID, 0, 7) == "subnet-"
    error_message = "The SUBNET_ID value must be a valid subnet identifier, starting with \"subnet-\"."
  }
}

variable "CODESTAR_CONNECTION_ARN" {
  type = string
  validation {
    condition     = length(var.CODESTAR_CONNECTION_ARN) > 0
    error_message = "The CODESTAR_CONNECTION_ARN value must not be empty."
  }
}

variable "REPOSITORY_NAME" {
  type = string
  validation {
    condition     = length(var.REPOSITORY_NAME) > 0
    error_message = "The REPOSITORY_NAME value must not be empty."
  }
}

variable "REPOSITORY_BRANCH" {
  type = string
  validation {
    condition     = length(var.REPOSITORY_BRANCH) > 0
    error_message = "The REPOSITORY_BRANCH value must not be empty."
  }
}

variable "EC2_PUBLIC_KEY" {
  type = string
}

variable "EC2_INSTANCE_TYPE" {
  type    = string
  default = "t3.medium"
}

variable "EC2_VOLUME_SIZE" {
  type    = number
  default = 50
}

variable "DOTENV" {
  type    = string
  default = null
}

variable "GIT_PRIVATE_KEY" {
  type    = string
  default = null
}

variable "SNS" {
  type = string
}
