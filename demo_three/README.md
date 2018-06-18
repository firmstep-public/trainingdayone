# Demo Three
### Create new resources that depend on data from another Terraform resource within another Terraform State.

This shows how to use the `terraform_remote_state` data structure to collect output data from a Terraform state.

```hcl
data "terraform_remote_state" "website" {
  backend = "s3"

  config {
    bucket = "${var.state_bucket}"
    key    = "${var.website_key}"
    region = "${var.state_region}"
  }
}
```
Then those outputs can be used in this Terraform script:
```hcl
  bucket       = "${data.terraform_remote_state.website.bucket_name}"
```