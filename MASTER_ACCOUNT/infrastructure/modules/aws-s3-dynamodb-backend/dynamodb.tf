
#######################################################################################################################
# DynamoDB row that "locks" and "unlocks" state, which prevents from simultaneous access.
#######################################################################################################################
resource "aws_dynamodb_table" "terraform_lock" {

  name         = lower("${var.ddb_lock_full_name}")
  billing_mode = var.ddb_billing_mode
  hash_key     = var.ddb_hash_key
  attribute {
    name = var.ddb_attribute_name
    type = var.ddb_attribute_type
  }
}
output "backend_ddb_id" {
  value = aws_dynamodb_table.terraform_lock.id
}

output "backend_ddb_arn" {
  value = aws_dynamodb_table.terraform_lock.arn
}