### For looking up info from the other Terraform States
variable "state_bucket" {
  description = "The bucket name where the Terraform state is kept"
}

variable "state_region" {
  description = "The region for the Terraform state bucket"
}

variable "website_key" {
  description = "The key_name for the website Terraform state"
}

variable "region" {
  description = "What region should the provider be in"
}
