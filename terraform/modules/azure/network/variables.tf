variable "name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "address_space" { type = list(string) }
variable "subnets" {
  type = map(object({ address_prefixes = list(string) }))
  validation {
    condition     = length(var.subnets) > 0
    error_message = "Specify at least one subnet."
  }
}
variable "tags" {
  type    = map(string)
  default = {}
}
