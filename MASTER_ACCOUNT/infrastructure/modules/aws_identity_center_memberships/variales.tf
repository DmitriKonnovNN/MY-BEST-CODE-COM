
variable "identity_store_id" {
  type     = string
  nullable = false
}

variable "identity_store_groups" {
  type = map(object({
    display_name = string
    group_id     = string

  }))
  nullable = false
}
variable "identity_store_users" {
  type = map(object({
    display_name = string
    user_id      = string

  }))
  nullable = false

}
