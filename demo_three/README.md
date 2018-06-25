# Demo Three
### Create new resources that depend on data from another Terraform resource within another Terraform State.

12.  Create a new template that uses remote terraform state to find the bucket name
13.  Create a new `aws_s3_bucket_object` to the terraform template that uploads `index.html` and `error.html` to the same bucket from another template using the discovered bucket name from the remote state to bucket

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