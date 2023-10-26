# variables.tf
variable "region" {
    description = "AWS Region"
    default     = "eu-central-1"
}

variable "email_address_1" {
  description = "Email address for subscription 1"
  type        = string
}

variable "email_address_2" {
  description = "Email address for subscription 2"
  type        = string
}

