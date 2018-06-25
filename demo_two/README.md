# Demo Two
### Configure a remote state so that the state information of Terraform isn't stored on the local computer.

1.  Create an `aws_s3_bucket` resource and configure it as a website endpoint.
2.  Add outputs to Terraform for bucket name and bucket endpoint
3.  Add external terraform state storage block to the `main.tf` file
4.  Use `terraform init` with the s3 bucket details to instruct terraform to use s3 remote state storage
5.  Use `terraform apply` to deploy the bucket, and save the state on s3.