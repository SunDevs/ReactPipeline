terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.31.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
