variable "full_bucket_name" {
  type = string
  nullable = false
}

variable "block_public_acls" {
  type = bool
  default = true
}
variable "block_public_policy" {
  type = bool
  default = true
}
variable "ignore_public_acls" {
  type = bool
  default = true
}
variable "restrict_public_buckets" {
  type = bool
  default = true
}
variable "bucket_versioning" {
  type = string
  default = "Enabled"
  validation {
    condition = (var.bucket_versioning == "Enabled") || (var.bucket_versioning == "Disabled") ? true : false
    error_message = "bucket_versioning accepts only two values: Enabled , Disabled"
  }
}
variable "bucket_key_enabled" {
  type = bool
  default = true
}
variable "bucket_sse_alg" {
  type = string
  default = "AES256"
}
variable "ddb_lock_full_name" {
  type = string
  nullable = false
}
variable "ddb_billing_mode" {
  type = string
  default = "PAY_PER_REQUEST"
}
variable "ddb_hash_key" {
  type = string
  default = "LockID"
}

variable "ddb_attribute_name" {
  type = string
  default = "LockID"

}
variable "ddb_attribute_type" {
  type = string
  default = "S"
}