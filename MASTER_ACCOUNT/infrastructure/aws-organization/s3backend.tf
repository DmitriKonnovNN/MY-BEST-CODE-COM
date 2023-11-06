module "aws-s3-dynamodb-backend" {
  source = "../modules/aws-s3-dynamodb-backend"
  full_bucket_name = "${var.organization_name}-master-backend-state"
  ddb_lock_full_name = "${var.organization_name}_master_backend_state_locking"
}