include "root" {
  path = find_in_parent_folders()
}
###################################################################################################################
# We use wrappers to be able to create multiple objects with the same module.
# Read documentation here: https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/tree/master/wrappers/object
# Don't forget to append "?version=X.XX.X" to the source, otherwise it'll fail.
###################################################################################################################
terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws//wrappers/object?version=3.15.1"
}

###################################################################################################################
# To make use of wrappers we must wrap our object including objects into items = {}
###################################################################################################################
dependency "s3-bucket" {
  config_path = "../s3-bucket"
}
#
inputs = {
  #  defaults = { # Default values
  #    create = false
  #    tags = {
  #      Environment = "sandbox"
  #    }
  #  }
  items = {
    js30devpipeline = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/dev/pipeline/"
    },
    js30prodpipeline = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/prod/pipeline/"
    },
    js30devcdn = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/dev/cloudfront/"
    },
    js30prodcdn = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/prod/cloudfront/"
    },
    js30prodapigw = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/prod/apigateway/"
    },
    js30devapigw = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/dev/apigateway/"
    },
    js30devlambda = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/dev/lambda/"
    },
    js30prodlambda = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/prod/lambda/"
    },
    js30devsqs = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/dev/sqs/"
    },
    js30prodsqs = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/prod/sqs/"
    },
    js30devcognito = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/dev/cognito/"
    },
    js30prodcognito = {
      bucket = dependency.s3-bucket.outputs.s3_bucket_id
      key    = "js30/prod/cognito/"
    }
  }

}

# What need to be deployed first (before this) useful for `terragrunt run-all apply`
dependencies {
  paths = ["../s3-bucket"]
}
