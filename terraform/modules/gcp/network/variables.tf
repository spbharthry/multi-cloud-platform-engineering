variable "project_id" { type = string }
variable "name" { type = string }
variable "region" { type = string }
variable "subnets" {
  type = map(string)
  validation {
    condition     = length(var.subnets) > 0
    error_message = "Specify at least one subnet."
  }
}
